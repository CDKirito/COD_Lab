module PIPELINE_REG (
    input                       clk,
    input                       rst,
    input                       en,
    input                       flush,
    input                       stall,

    // input
    input         [ 0:0]        commit_in,
    input         [31:0]        pc_in,
    input         [31:0]        pc_add4_in,
    input         [31:0]        inst_in,
    input         [ 4:0]        alu_op_in,
    input         [31:0]        imm_in,
    input         [ 4:0]        rf_wa_in,
    input         [ 0:0]        rf_we_in,
    input         [ 0:0]        alu_src0_sel_in,
    input         [ 0:0]        alu_src1_sel_in,
    input         [ 3:0]        dmem_access_in,
    input         [ 0:0]        dmem_we_in,
    input         [ 1:0]        rf_wd_sel_in,
    input         [ 3:0]        br_type_in,
    input         [ 4:0]        rf_ra0_in,
    input         [ 4:0]        rf_ra1_in,
    input         [31:0]        rf_rd0_in,
    input         [31:0]        rf_rd1_in,
    input         [31:0]        alu_res_in,
    input         [31:0]        dmem_rd_out_in,
    input         [31:0]        dmem_wd_out_in,

    // output
    output reg    [ 0:0]        commit_out,
    output reg    [31:0]        pc_out,
    output reg    [31:0]        pc_add4_out,
    output reg    [31:0]        inst_out,   
    output reg    [ 4:0]        alu_op_out,
    output reg    [31:0]        imm_out,
    output reg    [ 4:0]        rf_wa_out,
    output reg    [ 0:0]        rf_we_out,
    output reg    [ 0:0]        alu_src0_sel_out,
    output reg    [ 0:0]        alu_src1_sel_out,
    output reg    [ 3:0]        dmem_access_out,
    output reg    [ 0:0]        dmem_we_out,
    output reg    [ 1:0]        rf_wd_sel_out,
    output reg    [ 3:0]        br_type_out,
    output reg    [ 4:0]        rf_ra0_out,
    output reg    [ 4:0]        rf_ra1_out,
    output reg    [31:0]        rf_rd0_out,
    output reg    [31:0]        rf_rd1_out,
    output reg    [31:0]        alu_res_out,
    output reg    [31:0]        dmem_rd_out_out,
    output reg    [31:0]        dmem_wd_out_out
);

    always @(posedge clk) begin
        if (rst) begin
            commit_out       <= 1'b0;
            pc_out           <= 32'h0040_0000;
            pc_add4_out      <= 32'h0040_0004;
            inst_out         <= 32'h0;
            alu_op_out       <= 5'b0;
            imm_out          <= 32'b0;
            rf_wa_out        <= 5'b0;
            rf_we_out        <= 1'b0;
            alu_src0_sel_out <= 1'b0;
            alu_src1_sel_out <= 1'b0;
            dmem_access_out  <= 4'b0;
            dmem_we_out      <= 1'b0;
            rf_wd_sel_out    <= 2'b0;
            br_type_out      <= 4'b0;
            rf_ra0_out       <= 5'b0;
            rf_ra1_out       <= 5'b0;
            rf_rd0_out       <= 32'b0;
            rf_rd1_out       <= 32'b0;
            alu_res_out      <= 32'b0;
            dmem_rd_out_out  <= 32'b0;
            dmem_wd_out_out  <= 32'b0;
        
        end else if (en) begin
            if (flush) begin
                commit_out       <= 1'b0;
                pc_out           <= 32'h0040_0000;
                pc_add4_out      <= 32'h0040_0004;
                inst_out         <= 32'h0;
                alu_op_out       <= 5'b0;
                imm_out          <= 32'b0;
                rf_wa_out        <= 5'b0;
                rf_we_out        <= 1'b0;
                alu_src0_sel_out <= 1'b0;
                alu_src1_sel_out <= 1'b0;
                dmem_access_out  <= 4'b0;
                dmem_we_out      <= 1'b0;
                rf_wd_sel_out    <= 2'b0;
                br_type_out      <= 4'b0;
                rf_ra0_out       <= 5'b0;
                rf_ra1_out       <= 5'b0;
                rf_rd0_out       <= 32'b0;
                rf_rd1_out       <= 32'b0;
                alu_res_out      <= 32'b0;
                dmem_rd_out_out  <= 32'b0;
                dmem_wd_out_out  <= 32'b0;

            end else if (!stall) begin
                commit_out       <= commit_in;
                pc_out           <= pc_in; 
                pc_add4_out      <= pc_add4_in; 
                inst_out         <= inst_in; 
                alu_op_out       <= alu_op_in; 
                imm_out          <= imm_in; 
                rf_wa_out        <= rf_wa_in; 
                rf_we_out        <= rf_we_in; 
                alu_src0_sel_out <= alu_src0_sel_in; 
                alu_src1_sel_out <= alu_src1_sel_in; 
                dmem_access_out  <= dmem_access_in; 
                dmem_we_out      <= dmem_we_in; 
                rf_wd_sel_out    <= rf_wd_sel_in; 
                br_type_out      <= br_type_in;
                rf_ra0_out       <= rf_ra0_in;
                rf_ra1_out       <= rf_ra1_in;
                rf_rd0_out       <= rf_rd0_in;
                rf_rd1_out       <= rf_rd1_in;
                alu_res_out      <= alu_res_in;
                dmem_rd_out_out  <= dmem_rd_out_in;
                dmem_wd_out_out  <= dmem_wd_out_in;
            end
        end
    end
    
endmodule