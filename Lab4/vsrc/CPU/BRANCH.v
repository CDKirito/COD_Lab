module BRANCH(
    input                   [ 3 : 0]            br_type,

    input                   [31 : 0]            br_src0,
    input                   [31 : 0]            br_src1,

    output      reg         [ 1 : 0]            npc_sel
);

    `define BR_NJP              4'b0000
    `define BR_JALR             4'b0001
    `define BR_JAL              4'b0010
    `define BR_BEQ              4'b0011
    `define BR_BNE              4'b0100
    `define BR_BLT              4'b0101
    `define BR_BGE              4'b0110
    `define BR_BLTU             4'b0111
    `define BR_BGEU             4'b1000

    `define PC_ADD4     2'b00
    `define PC_OFFSET   2'b01
    `define PC_JALR     2'b10

    always @(*) begin
        npc_sel = 2'b00;

        case (br_type)
            `BR_JALR: npc_sel = `PC_JALR;
            `BR_JAL : npc_sel = `PC_OFFSET;
            `BR_BEQ : npc_sel = (br_src0 == br_src1) ? `PC_OFFSET : `PC_ADD4;
            `BR_BNE : npc_sel = (br_src0 != br_src1) ? `PC_OFFSET : `PC_ADD4;
            `BR_BLT : npc_sel = ($signed(br_src0) < $signed(br_src1)) ? `PC_OFFSET : `PC_ADD4;
            `BR_BGE : npc_sel = ($signed(br_src0) >= $signed(br_src1)) ? `PC_OFFSET : `PC_ADD4;
            `BR_BLTU: npc_sel = (br_src0 < br_src1) ? `PC_OFFSET : `PC_ADD4;
            `BR_BGEU: npc_sel = (br_src0 >= br_src1) ? `PC_OFFSET : `PC_ADD4;
            default : npc_sel = `PC_ADD4;
        endcase

    end    

endmodule