module CPU (
    input                   [ 0 : 0]            clk,
    input                   [ 0 : 0]            rst,

    input                   [ 0 : 0]            global_en,

/* ------------------------------ Memory (inst) ----------------------------- */
    output                  [31 : 0]            imem_raddr,
    input                   [31 : 0]            imem_rdata,

/* ------------------------------ Memory (data) ----------------------------- */
    input                   [31 : 0]            dmem_rdata,
    output                  [ 0 : 0]            dmem_we,
    output                  [31 : 0]            dmem_addr,
    output                  [31 : 0]            dmem_wdata,

/* ---------------------------------- Debug --------------------------------- */
    output                  [ 0 : 0]            commit,
    output                  [31 : 0]            commit_pc,
    output                  [31 : 0]            commit_inst,
    output                  [ 0 : 0]            commit_halt,
    output                  [ 0 : 0]            commit_reg_we,
    output                  [ 4 : 0]            commit_reg_wa,
    output                  [31 : 0]            commit_reg_wd,
    output                  [ 0 : 0]            commit_dmem_we,
    output                  [31 : 0]            commit_dmem_wa,
    output                  [31 : 0]            commit_dmem_wd,

    input                   [ 4 : 0]            debug_reg_ra,   // TODO
    output                  [31 : 0]            debug_reg_rd    // TODO
);

    `define HALT_INST 32'H00100073

    // Commit
    reg  [ 0 : 0]   commit_reg          ;
    reg  [31 : 0]   commit_pc_reg       ;
    reg  [31 : 0]   commit_inst_reg     ;
    reg  [ 0 : 0]   commit_halt_reg     ;
    reg  [ 0 : 0]   commit_reg_we_reg   ;
    reg  [ 4 : 0]   commit_reg_wa_reg   ;
    reg  [31 : 0]   commit_reg_wd_reg   ;
    reg  [ 0 : 0]   commit_dmem_we_reg  ;
    reg  [31 : 0]   commit_dmem_wa_reg  ;
    reg  [31 : 0]   commit_dmem_wd_reg  ;

    // Commit
    always @(posedge clk) begin
        if (rst) begin
            commit_reg          <= 1'B0;
            commit_pc_reg       <= 32'H0;
            commit_inst_reg     <= 32'H0;
            commit_halt_reg     <= 1'B0;
            commit_reg_we_reg   <= 1'B0;
            commit_reg_wa_reg   <= 5'H0;
            commit_reg_wd_reg   <= 32'H0;
            commit_dmem_we_reg  <= 1'B0;
            commit_dmem_wa_reg  <= 32'H0;
            commit_dmem_wd_reg  <= 32'H0;
        end
        else if (global_en) begin
            commit_reg          <= 1'B1;
            commit_pc_reg       <= pc;
            commit_inst_reg     <= inst;
            commit_halt_reg     <= inst == `HALT_INST;
            commit_reg_we_reg   <= rf_we;
            commit_reg_wa_reg   <= rf_wa;
            commit_reg_wd_reg   <= rf_wd;
            commit_dmem_we_reg  <= 0;
            commit_dmem_wa_reg  <= 0;
            commit_dmem_wd_reg  <= 0;
        end
    end

    assign commit           = commit_reg;
    assign commit_pc        = commit_pc_reg;
    assign commit_inst      = commit_inst_reg;
    assign commit_halt      = commit_halt_reg;
    assign commit_reg_we    = commit_reg_we_reg;
    assign commit_reg_wa    = commit_reg_wa_reg;
    assign commit_reg_wd    = commit_reg_wd_reg;
    assign commit_dmem_we   = commit_dmem_we_reg;
    assign commit_dmem_wa   = commit_dmem_wa_reg;
    assign commit_dmem_wd   = commit_dmem_wd_reg;


    wire [31 : 0] pc;
    wire [31 : 0] npc;
    wire [31 : 0] inst;
    wire [31 : 0] rf_rd0;
    wire [31 : 0] rf_rd1;
    wire [31 : 0] rf_wd;
    wire [ 4 : 0] rf_ra0;
    wire [ 4 : 0] rf_ra1;
    wire [ 4 : 0] rf_wa;
    wire [ 0 : 0] rf_we;
    wire [31 : 0] alu_src0;
    wire [31 : 0] alu_src1;
    wire [ 0 : 0] alu_src0_sel;
    wire [ 0 : 0] alu_src1_sel;
    wire [ 4 : 0] alu_op;
    wire [31 : 0] alu_res;
    wire [31 : 0] imm;


    PC my_pc (
        .clk    (clk),
        .rst    (rst),
        .en     (global_en),    // 当 global_en 为高电平时，PC 才会更新，CPU 才会执行指令。
        .npc    (npc),
        .pc     (pc)
    );

    ADD4 add4 (
        .in     (pc),
        .out    (npc)
    );

    DECODER decoder (
        .inst           (inst),
        .alu_op         (alu_op),
        .imm            (imm),
        .rf_ra0         (rf_ra0),
        .rf_ra1         (rf_ra1),
        .rf_wa          (rf_wa),
        .rf_we          (rf_we),
        .alu_src0_sel   (alu_src0_sel),
        .alu_src1_sel   (alu_src1_sel)
    );

    REGFILE regfile (
        .clk        (clk),
        .rf_ra0     (rf_ra0),
        .rf_ra1     (rf_ra1),
        .dbg_rf_ra  (debug_reg_ra),
        .rf_wa      (rf_wa),
        .rf_we      (rf_we),
        .rf_wd      (rf_wd),
        .rf_rd0     (rf_rd0),
        .rf_rd1     (rf_rd1),
        .dbg_rf_rd  (debug_reg_rd)
    );

    MUX #(.WIDTH(32)) mux0 (
        .src0       (rf_rd0),
        .src1       (pc),
        .sel        (alu_src0_sel),
        .res        (alu_src0)
    );

    MUX #(.WIDTH(32)) mux1 (
        .src0       (rf_rd1),
        .src1       (imm),
        .sel        (alu_src1_sel),
        .res        (alu_src1)
    );

    ALU alu (
        .alu_op     (alu_op),
        .alu_src0   (alu_src0),
        .alu_src1   (alu_src1),
        .alu_res    (alu_res)
    );

    assign rf_wd = alu_res;
    assign imem_raddr = pc;
    assign inst = imem_rdata;

endmodule