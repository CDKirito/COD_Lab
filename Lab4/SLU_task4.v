module SLU (
    input                   [31:0]                addr,
    input                   [ 3:0]                dmem_access,
    input                   [31:0]                rd_in,
    input                   [31:0]                wd_in,
    output reg              [ 3:0]                mask,     // 读写掩码
    output reg              [31:0]                rd_out,
    output reg              [31:0]                wd_out
);

    `define LB                  4'b0000     // Load Byte
    `define LH                  4'b0001     // Load Halfword
    `define LW                  4'b0010     // Load Word
    `define LBU                 4'b0011     // Load Byte Unsigned
    `define LHU                 4'b0100     // Load Halfword Unsigned
    `define SB                  4'b0101     // Store Byte    
    `define SH                  4'b0110     // Store Halfword    
    `define SW                  4'b0111     // Store Word

    always @(*) begin
        mask = 4'b1111; // 默认掩码为全1
        rd_out = rd_in; // 默认读取数据为输入数据
        wd_out = wd_in; // 默认写入数据为输入数据
        case (dmem_access)
            `LB: begin
                case (addr[1:0])
                    2'b00: rd_out = {{24{rd_in[ 7]}}, rd_in[ 7: 0]};    // 读取低字节
                    2'b01: rd_out = {{24{rd_in[15]}}, rd_in[15: 8]};    // 读取中低字节
                    2'b10: rd_out = {{24{rd_in[23]}}, rd_in[23:16]};    // 读取中高字节
                    2'b11: rd_out = {{24{rd_in[31]}}, rd_in[31:24]};    // 读取高字节
                endcase
            end

            `LH: begin
                case (addr[1:0])
                    2'b00: rd_out = {{16{rd_in[15]}}, rd_in[15:0]};     // 读取低半字
                    2'b10: rd_out = {{16{rd_in[31]}}, rd_in[31:16]};    // 读取高半字
                    default: rd_out = 32'b0;
                endcase
            end

            `LW: begin
                rd_out = rd_in; // 读取字
            end
            
            `LBU: begin
                case (addr[1:0])
                    2'b00: rd_out = {24'b0, rd_in[7:0]};        // 读取低字节
                    2'b01: rd_out = {24'b0, rd_in[15:8]};       // 读取中低字节
                    2'b10: rd_out = {24'b0, rd_in[23:16]};      // 读取中高字节
                    2'b11: rd_out = {24'b0, rd_in[31:24]};      // 读取高字节
                endcase
            end

            `LHU: begin
                case (addr[1:0])
                    2'b00: rd_out = {16'b0, rd_in[15:0]};        // 读取低半字
                    2'b10: rd_out = {16'b0, rd_in[31:16]};       // 读取高半字
                    default: rd_out = 32'b0;
                endcase
            end

            `SB: begin
                case (addr[1:0])
                    2'b00: mask = 4'b0001;              // 写入低字节
                    2'b01: mask = 4'b0010;              // 写入中低字节
                    2'b10: mask = 4'b0100;              // 写入中高字节
                    2'b11: mask = 4'b1000;              // 写入高字节
                endcase
            end

            `SH: begin
                case (addr[1:0])
                    2'b00: mask = 4'b0011;              // 写入低半字
                    2'b10: mask = 4'b1100;              // 写入高半字
                endcase
            end

            `SW: begin
                wd_out = wd_in; // 写入字
            end

            default: begin
                wd_out = 32'b0;
                rd_out = 32'b0;
            end
        endcase
    end
endmodule