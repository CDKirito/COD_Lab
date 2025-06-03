module top (
    input wire [5:0] a,       // 地址输入
    input wire [31:0] d,      // 数据输入
    input wire clk,           // 时钟信号
    input wire we,            // 写使能信号
    output wire [31:0] spo    // 数据输出
);

    // 实例化 dist_mem_gen_0
    dist_mem_gen_0 u_dist_mem_gen_0 (
        .a(a),      
        .d(d),      
        .clk(clk),  
        .we(we),    
        .spo(spo)   
    );

endmodule