/*
直接映射Cache
- Cache行数：8行
- 块大小：4字（16字节 128位）
- 采用写回写分配策略
*/
module cache #(
    parameter INDEX_WIDTH       = 3,    // Cache索引位宽 2^3=8行
    parameter LINE_OFFSET_WIDTH = 2,    // 行偏移位宽，决定了一行的宽度 2^2=4字
    parameter SPACE_OFFSET      = 2,    // 一个地址空间占1个字节，因此一个字需要4个地址空间，由于假设为整字读取，处理地址的时候可以默认后两位为0
    parameter WAY_NUM           = 1     // Cache N路组相联(N=1的时候是直接映射)
)(
    input                     clk,    
    input                     rstn,
    /* CPU接口 */  
    input [31:0]              addr,   // CPU地址
    input                     r_req,  // CPU读请求
    input                     w_req,  // CPU写请求
    input [31:0]              w_data,  // CPU要写入的数据
    output [31:0]             r_data,  // CPU读数据
    output reg                miss,   // 缓存未命中，此信号有效时，CPU停驻
    /* 内存接口 */  
    output reg                     mem_r,  // 内存读请求
    output reg                     mem_w,  // 内存写请求
    output reg [31:0]              mem_addr,  // 内存地址
    output reg [127:0]             mem_w_data,  // 内存写数据 一次写一行
    input      [127:0]             mem_r_data,  // 内存读数据 一次读一行
    input                          mem_ready  // 内存就绪信号
);

    // Cache参数
    localparam
        // Cache行宽度
        LINE_WIDTH = 32 << LINE_OFFSET_WIDTH,
        // 标记位宽度
        TAG_WIDTH = 32 - INDEX_WIDTH - LINE_OFFSET_WIDTH - SPACE_OFFSET,
        // Cache行数
        SET_NUM   = 1 << INDEX_WIDTH,
        // 路地址宽度
        WAY_WIDTH = $clog2(WAY_NUM);
    
    // Cache相关寄存器
    reg [31:0]           addr_buf;    // 请求地址缓存-用于保留CPU请求地址
    reg [31:0]           w_data_buf;  // 写数据缓存
    reg op_buf;  // 读写操作缓存，用于在MISS状态下判断是读还是写，如果是写则需要将数据写回内存 0:读 1:写
    reg [LINE_WIDTH-1:0] ret_buf;     // 返回数据缓存-用于保留内存返回数据

    // Cache导线
    wire [INDEX_WIDTH-1:0] r_index;  // 索引读地址
    wire [INDEX_WIDTH-1:0] w_index;  // 索引写地址
    wire [LINE_WIDTH-1:0]  r_line;  // Data Bram读数据
    wire [LINE_WIDTH-1:0]  r_line_way [WAY_NUM-1:0];   // Data Bram读数据
    wire [LINE_WIDTH-1:0]  w_line;   // Data Bram写数据
    wire [LINE_WIDTH-1:0]  w_line_mask;  // Data Bram写数据掩码
    wire [LINE_WIDTH-1:0]  w_data_line;  // 输入写数据移位后的数据
    wire [TAG_WIDTH-1:0]   tag;      // CPU请求地址中分离的标记 用于比较 也可用于写入
    wire [TAG_WIDTH-1:0]   r_tag;    // Tag Bram读数据 用于比较
    wire [TAG_WIDTH-1:0]   r_tag_way [WAY_NUM-1:0];   // Tag Bram分路读数据 用于比较
    wire [LINE_OFFSET_WIDTH-1:0] word_offset;  // 字偏移
    reg  [31:0]            cache_data;  // Cache数据
    reg  [31:0]            mem_data;    // 内存数据
    wire [31:0]            dirty_mem_addr; // 通过读出的tag和对应的index，偏移等得到脏块对应的内存地址并写回到正确的位置
    wire [WAY_NUM-1:0] valid;  // Cache分路有效位
    wire                 dirty;  // Cache脏位
    wire [WAY_NUM-1:0] dirty_way;  // Cache分路脏位.
    reg  w_valid;  // Cache写有效位
    reg  w_dirty;  // Cache写脏位
    wire [WAY_NUM-1:0] hit_way;    // Cache单路命中
    wire hit;       // Cache总命中信号
    reg  [WAY_WIDTH-1:0] replace_way; // 替换路索引
    reg  [WAY_WIDTH-1:0] lru_state [SET_NUM-1:0][WAY_NUM-1:0]; // 每组LRU状态
    reg  [WAY_WIDTH-1:0] fifo_state [SET_NUM-1:0]; // 每组FIFO状态

    // Cache相关控制信号
    reg addr_buf_we;  // 请求地址缓存写使能
    reg ret_buf_we;   // 返回数据缓存写使能
    wire [WAY_NUM-1:0] data_we_way;      // Cache数据分路写使能
    reg data_we;      // Cache数据总写使能
    wire [WAY_NUM-1:0] tag_we_way;       // Cache标签分路写使能
    reg tag_we;       // Cache标签总写使能
    reg data_from_mem;  // 从内存读取数据
    reg refill;       // 标记需要重新填充，在MISS状态下接受到内存数据后置1,在IDLE状态下进行填充后置0

    // 状态机信号
    localparam 
        IDLE      = 3'd0,  // 空闲状态
        READ      = 3'd1,  // 读状态
        MISS      = 3'd2,  // 缺失时等待主存读出新块
        WRITE     = 3'd3,  // 写状态
        W_DIRTY   = 3'd4;  // 写缺失时等待主存写入脏块
    reg [2:0] CS;  // 状态机当前状态
    reg [2:0] NS;  // 状态机下一状态

    // 状态机
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            CS <= IDLE;
        end else begin
            CS <= NS;
        end
    end

    // 中间寄存器保留初始的请求地址和写数据，可以理解为addr_buf中的地址为当前Cache正在处理的请求地址，而addr中的地址为新的请求地址
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            addr_buf <= 0;
            ret_buf <= 0;
            w_data_buf <= 0;
            op_buf <= 0;
            refill <= 0;
        end else begin
            if (addr_buf_we) begin
                addr_buf <= addr;
                w_data_buf <= w_data;
                op_buf <= w_req;
            end
            if (ret_buf_we) begin
                ret_buf <= mem_r_data;
            end
            if (CS == MISS && mem_ready) begin
                refill <= 1;
            end
            if (CS == IDLE) begin
                refill <= 0;
            end
        end
    end

    // 对输入地址进行解码
    assign r_index = addr[INDEX_WIDTH+LINE_OFFSET_WIDTH+SPACE_OFFSET - 1: LINE_OFFSET_WIDTH+SPACE_OFFSET];
    assign w_index = addr_buf[INDEX_WIDTH+LINE_OFFSET_WIDTH+SPACE_OFFSET - 1: LINE_OFFSET_WIDTH+SPACE_OFFSET];
    assign tag = addr_buf[31:INDEX_WIDTH+LINE_OFFSET_WIDTH+SPACE_OFFSET];
    assign word_offset = addr_buf[LINE_OFFSET_WIDTH+SPACE_OFFSET-1:SPACE_OFFSET];

    // 脏块地址计算
    assign dirty_mem_addr = {r_tag, w_index}<<(LINE_OFFSET_WIDTH+SPACE_OFFSET);

    // 写回地址、数据寄存器
    reg [31:0] dirty_mem_addr_buf;
    reg [127:0] dirty_mem_data_buf;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            dirty_mem_addr_buf <= 0;
            dirty_mem_data_buf <= 0;
        end else begin
            if (CS == READ || CS == WRITE) begin
                dirty_mem_addr_buf <= dirty_mem_addr;
                dirty_mem_data_buf <= r_line;
            end
        end
    end

    // 参数化产生cache的各个分路，每个分路有一个Tag Bram和一个Data Bram
    genvar i;
    generate
        for (i = 0; i < WAY_NUM; i = i + 1) begin : way_gen
            // Tag Bram
            bram #(
                .ADDR_WIDTH(INDEX_WIDTH),
                .DATA_WIDTH(TAG_WIDTH + 2) // 最高位为有效位，次高位为脏位，低位为标记位
            ) tag_bram(
                .clk(clk),
                .raddr(r_index),
                .waddr(w_index),
                .din({w_valid, w_dirty, tag}),
                .we(tag_we_way[i]),
                .dout({valid[i], dirty_way[i], r_tag_way[i]})
            );

            // Data Bram
            bram #(
                .ADDR_WIDTH(INDEX_WIDTH),
                .DATA_WIDTH(LINE_WIDTH)
            ) data_bram(
                .clk(clk),
                .raddr(r_index),
                .waddr(w_index),
                .din(w_line),
                .we(data_we_way[i]),
                .dout(r_line_way[i])
            );

            // 分路命中判断：该分路的有效位为1且标签匹配
            assign hit_way[i] = valid[i] && (r_tag_way[i] == tag);
            // 分路写使能：总写使能信号有效时，如果命中，选择命中路；如果未命中，则选择替换路
            assign tag_we_way[i] = tag_we && (hit ? hit_way[i] : (replace_way == i));
            assign data_we_way[i] = data_we && (hit ? hit_way[i] : (replace_way == i));
        end
    endgenerate

    // 总命中信号，只在读或写状态下判断命中
    assign hit = (|hit_way) && (CS == READ || CS == WRITE);
   
    // 命中路索引：选择hit_way中为1的分路索引
    reg [WAY_WIDTH-1:0] hit_way_idx;
    always @(*) begin
        hit_way_idx = 0;
        for (integer i = 0; i < WAY_NUM; i = i + 1) begin
            if (hit_way[i]) begin
                hit_way_idx = i;
            end
        end
    end

/* ------------------------- LRU替换策略相关 ------------------------- */
    
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            // 重置LRU状态
            for (integer j = 0; j < SET_NUM; j = j + 1) begin
                for (integer k = 0; k < WAY_NUM; k = k + 1) begin
                    lru_state[j][k] <= 0;
                end
            end
        end else if (hit) begin
            for (integer i = 0; i < WAY_NUM; i = i + 1) begin
                if (i == hit_way_idx) begin
                    lru_state[w_index][i] <= WAY_NUM - 1;
                end else begin
                    if (lru_state[w_index][i] > lru_state[w_index][hit_way_idx]) begin
                        lru_state[w_index][i] <= lru_state[w_index][i] - 1; // LRU状态减1
                    end
                end
            end
        end else if (refill) begin
            for (integer i = 0; i < WAY_NUM; i = i + 1) begin
                if (i == replace_way) begin
                    lru_state[w_index][i] <= WAY_NUM - 1; // 替换路状态置为最大值
                end else begin
                    if (lru_state[w_index][i] > lru_state[w_index][replace_way]) begin
                        lru_state[w_index][i] <= lru_state[w_index][i] - 1; // LRU状态减1
                    end
                end
            end
        end
    end

    // 替换路索引
    always @(*) begin
        replace_way = 0;
        for (integer i = 1; i < WAY_NUM; i = i + 1) begin
            if (lru_state[w_index][i] == 0) begin
                replace_way = i;
            end
        end
    end
    

/* ---------------------------- FIFO替换 ------------------------- */
    /*
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            for (integer j = 0; j < SET_NUM; j = j + 1) begin
                fifo_state[j] <= 0; // FIFO状态初始化为0
            end
        end else if (refill) begin
            if (fifo_state[w_index] == WAY_NUM - 1) begin
                fifo_state[w_index] <= 0; // 如果FIFO状态已满，则重置为0
            end else begin
                fifo_state[w_index] <= fifo_state[w_index] + 1; // FIFO状态递增
            end
        end
    end

    // 替换路索引
    always @(*) begin
        replace_way = fifo_state[w_index];
    end
    */

/* ---------------------------- 随机替换 ------------------------- */
    /*
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            replace_way <= 0;
        end else if (refill) begin
            if (replace_way < WAY_NUM - 1) begin
                replace_way <= replace_way + 1; // 替换路索引递增
            end else begin
                replace_way <= 0; // 循环替换
            end
        end
    end
    */

    assign dirty = dirty_way[replace_way]; // 如果替换路是脏的，则dirty为1
    
    // 选择命中路数据
    assign r_line = hit ? r_line_way[hit_way_idx] : // 命中时选择对应路的数据
                          r_line_way[replace_way];  // 未命中时选择替换路的数据

    // 选择命中路标签
    assign r_tag = hit ? r_tag_way[hit_way_idx] : // 命中时选择对应路的标签
                         r_tag_way[replace_way];  // 未命中时选择替换路的标签


    // 写入Cache 这里要判断是命中后写入还是未命中后写入
    assign w_line_mask = 32'hFFFFFFFF << (word_offset*32);   // 写入数据掩码
    assign w_data_line = w_data_buf << (word_offset*32);     // 写入数据移位
    assign w_line = (CS == IDLE && op_buf) ? ret_buf & ~w_line_mask | w_data_line : // 写入未命中，需要将内存数据（来自mem）与写入数据合并
                              (CS == IDLE) ? ret_buf : // 读取未命中
                                             r_line & ~w_line_mask | w_data_line; // 写入命中,需要对读取的数据（来自cache）与写入数据进行合并

    // 选择输出数据 从Cache或者从内存 这里的选择与行大小有关，因此如果你调整了行偏移位宽，这里也需要调整
    always @(*) begin
        case (word_offset)
            0: begin
                cache_data = r_line[31:0];
                mem_data = ret_buf[31:0];
            end
            1: begin
                cache_data = r_line[63:32];
                mem_data = ret_buf[63:32];
            end
            2: begin
                cache_data = r_line[95:64];
                mem_data = ret_buf[95:64];
            end
            3: begin
                cache_data = r_line[127:96];
                mem_data = ret_buf[127:96];
            end
            default: begin
                cache_data = 0;
                mem_data = 0;
            end
        endcase
    end


    assign r_data = data_from_mem ? mem_data : 
                              hit ? cache_data : 
                                    0;

    // 状态机更新逻辑
    always @(*) begin
        case(CS)
            IDLE: begin
                if (r_req) begin
                    NS = READ;
                end else if (w_req) begin
                    NS = WRITE;
                end else begin
                    NS = IDLE;
                end
            end
            READ: begin
                if (miss&& !dirty) begin
                    NS = MISS;
                end else if (miss && dirty) begin
                    NS = W_DIRTY;
                end else if (r_req) begin
                    NS = READ;
                end else if (w_req) begin
                    NS = WRITE;
                end else begin
                    NS = IDLE;
                end
            end
            MISS: begin
                if (mem_ready) begin // 这里回到IDLE的原因是为了延迟一周期，等待主存读出的新块写入Cache中的对应位置
                    NS = IDLE;
                end else begin
                    NS = MISS;
                end
            end
            WRITE: begin
                if (miss && !dirty) begin
                    NS = MISS;
                end else if (miss && dirty) begin
                    NS = W_DIRTY;
                end else if (r_req) begin
                    NS = READ;
                end else if (w_req) begin
                    NS = WRITE;
                end else begin
                    NS = IDLE;
                end
            end
            W_DIRTY: begin
                if (mem_ready) begin  // 写完脏块后回到MISS状态等待主存读出新块
                    NS = MISS;
                end else begin
                    NS = W_DIRTY;
                end
            end
            default: begin
                NS = IDLE;
            end
        endcase
    end

    // 状态机控制信号
    always @(*) begin
        addr_buf_we   = 1'b0;
        ret_buf_we    = 1'b0;
        data_we       = 1'b0;
        tag_we        = 1'b0;
        w_valid       = 1'b0;
        w_dirty       = 1'b0;
        data_from_mem = 1'b0;
        miss          = 1'b0;
        mem_r         = 1'b0;
        mem_w         = 1'b0;
        mem_addr      = 32'b0;
        mem_w_data    = 0;
        case(CS)
            IDLE: begin
                addr_buf_we = 1'b1; // 请求地址缓存写使能
                miss = 1'b0;
                ret_buf_we = 1'b0;
                if(refill) begin
                    data_from_mem = 1'b1;
                    w_valid = 1'b1;
                    w_dirty = 1'b0;
                    data_we = 1'b1;
                    tag_we = 1'b1;
                    if (op_buf) begin // 写
                        w_dirty = 1'b1;
                    end 
                end
            end
            READ: begin
                data_from_mem = 1'b0;
                if (hit) begin // 命中
                    miss = 1'b0;
                    addr_buf_we = 1'b1; // 请求地址缓存写使能
                end else begin // 未命中
                    miss = 1'b1;
                    addr_buf_we = 1'b0; 
                    if (dirty) begin // 脏数据需要写回
                        mem_w = 1'b1;
                        mem_addr = dirty_mem_addr;
                        mem_w_data = r_line; // 写回数据
                    end
                end
            end
            MISS: begin
                miss = 1'b1;
                mem_r = 1'b1;
                mem_addr = addr_buf;
                if (mem_ready) begin
                    mem_r = 1'b0;
                    ret_buf_we = 1'b1;
                end 
            end
            WRITE: begin
                data_from_mem = 1'b0;
                if (hit) begin // 命中
                    miss = 1'b0;
                    addr_buf_we = 1'b1; // 请求地址缓存写使能
                    w_valid = 1'b1;
                    w_dirty = 1'b1;
                    data_we = 1'b1;
                    tag_we = 1'b1;
                end else begin // 未命中
                    miss = 1'b1;
                    addr_buf_we = 1'b0; 
                    if (dirty) begin // 脏数据需要写回
                        mem_w = 1'b1;
                        mem_addr = dirty_mem_addr;
                        mem_w_data = r_line; // 写回数据
                    end
                end
            end
            W_DIRTY: begin
                miss = 1'b1;
                mem_w = 1'b1;
                mem_addr = dirty_mem_addr_buf;
                mem_w_data = dirty_mem_data_buf;
                if (mem_ready) begin
                    mem_w = 1'b0;
                end
            end
            default:;
        endcase
    end

    reg [31:0] hit_counter; // 命中计数器
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            hit_counter <= 0;
        end else if (hit) begin
            hit_counter <= hit_counter + 1; // 每次命中计数器加1
        end
    end
endmodule