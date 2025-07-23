`timescale 1ns / 1ps

module top_tb;

    // 输入信号
    reg [5:0] a;          // 地址输入
    reg clk;              // 时钟信号

    // 输出信号
    wire [31:0] spo;      // 数据输出

    // 实例化被测试模块
    top uut (
        .a(a),
        .d(32'b0),        // 写数据固定为0，因为只读
        .clk(clk),
        .we(1'b0),        // 写使能为0，因为只读
        .spo(spo)
    );

    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns 时钟周期
    end

    // 仿真测试
    initial begin
        // 初始化
        a = 6'b000000;

        // 读取地址 0
        #10;

        // 读取地址 1
        a = 6'b000001;
        #10;

        // 读取地址 2
        a = 6'b000010;
        #10;

        // 读取地址 3
        a = 6'b000011;
        #10;

        // 结束仿真
        #10;
        $finish;
    end

endmodule