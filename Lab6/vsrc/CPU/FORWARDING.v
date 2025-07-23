module FORWARDING (
    input                   [ 4 : 0]            rf_ra0_ex,
    input                   [ 4 : 0]            rf_ra1_ex,

    input                   [ 4 : 0]            rf_wa_mem,
    input                   [ 0 : 0]            rf_we_mem,
    input                   [ 4 : 0]            rf_wa_wb,
    input                   [ 0 : 0]            rf_we_wb,

    output      reg         [ 1 : 0]            forward0,
    output      reg         [ 1 : 0]            forward1
);

    // LOAD 指令会冲刷掉下一条指令，JALR 指令会冲刷掉接下来两条指令
    always @(*) begin
        forward0 = 2'b00;
        forward1 = 2'b00;

        if (rf_wa_mem != 0 && rf_wa_mem == rf_ra0_ex && rf_we_mem) begin
            forward0 = 2'b10;
        end else if (rf_wa_wb != 0 && rf_wa_wb == rf_ra0_ex && rf_we_wb) begin
            forward0 = 2'b01;
        end

        if (rf_wa_mem != 0 && rf_wa_mem == rf_ra1_ex && rf_we_mem) begin
            forward1 = 2'b10;
        end else if (rf_wa_wb != 0 && rf_wa_wb == rf_ra1_ex && rf_we_wb) begin
            forward1 = 2'b01;
        end
    end
endmodule