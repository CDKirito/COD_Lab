module REGFILE (
    input                   [ 0 : 0]        clk,

    input                   [ 4 : 0]        rf_ra0,     // 读寄存器地址
    input                   [ 4 : 0]        rf_ra1,   
    input                   [ 4 : 0]        dbg_rf_ra,  // debug读寄存器地址
    input                   [ 4 : 0]        rf_wa,      // 写寄存器地址
    input                   [ 0 : 0]        rf_we,      // 写使能信号
    input                   [31 : 0]        rf_wd,      // 写数据

    output                  [31 : 0]        rf_rd0,     // 读数据
    output                  [31 : 0]        rf_rd1,
    output                  [31 : 0]        dbg_rf_rd   // debug读数据
);

    reg [31 : 0] reg_file [0 : 31];

    // 用于初始化寄存器
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            reg_file[i] = 0;
    end

    always @(posedge clk) begin
        if (rf_we && (rf_wa != 0)) begin
            reg_file[rf_wa] <= rf_wd;
        end
    end

    assign rf_rd0 = reg_file[rf_ra0];
    assign rf_rd1 = reg_file[rf_ra1];
    assign dbg_rf_rd = reg_file[dbg_rf_ra];

endmodule