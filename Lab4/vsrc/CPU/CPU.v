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

    input                   [ 4 : 0]            debug_reg_ra,
    output                  [31 : 0]            debug_reg_rd
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
            commit_dmem_we_reg  <= dmem_we;
            commit_dmem_wa_reg  <= dmem_addr;
            commit_dmem_wd_reg  <= dmem_wdata;
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
    wire [31 : 0] pc_add4;
    wire [31 : 0] pc_offset;
    wire [31 : 0] pc_jalr;
    wire [31 : 0] npc;
    wire [ 1 : 0] npc_sel;
    wire [ 3 : 0] br_type;

    wire [31 : 0] inst;
    wire [31 : 0] rf_rd0;
    wire [31 : 0] rf_rd1;
    wire [31 : 0] rf_wd;
    wire [ 1 : 0] rf_wd_sel;
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

    wire [ 3 : 0] dmem_access;
    wire [31 : 0] dmem_rd_out;
    wire [31 : 0] dmem_rd_in;
    wire [31 : 0] dmem_wd_in;
    wire [31 : 0] dmem_wd_out;


    PC my_pc (
        .clk    (clk),
        .rst    (rst),
        .en     (global_en),
        .npc    (npc),
        .pc     (pc)
    );

    ADD_4 add_pc (
        .in     (pc),
        .out    (pc_add4)
    );

    CLR_LSB clr_lsb (
        .in     (pc_offset),
        .out    (pc_jalr)
    );

    MUX_3 #(.WIDTH(32)) pc_mux (
        .src0   (pc_add4),
        .src1   (pc_offset),
        .src2   (pc_jalr),
        .sel    (npc_sel),
        .res    (npc)
    );

    BRANCH branch (
        .br_type    (br_type),
        .br_src0    (rf_rd0),
        .br_src1    (rf_rd1),
        .npc_sel    (npc_sel)
    );

    assign pc_offset = alu_res;

    DECODER decoder (
        .inst           (inst),
        .alu_op         (alu_op),
        .imm            (imm),
        .rf_ra0         (rf_ra0),
        .rf_ra1         (rf_ra1),
        .rf_wa          (rf_wa),
        .rf_we          (rf_we),
        .alu_src0_sel   (alu_src0_sel),
        .alu_src1_sel   (alu_src1_sel),
        .dmem_access    (dmem_access),
        .dmem_we        (dmem_we),
        .rf_wd_sel      (rf_wd_sel),
        .br_type        (br_type)
    );

    MUX_3 #(.WIDTH(32)) rf_wd_mux (
        .src0       (pc_add4),
        .src1       (alu_res),
        .src2       (dmem_rd_out),
        .sel        (rf_wd_sel),
        .res        (rf_wd)
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

    MUX_2 #(.WIDTH(32)) alu_mux0 (
        .src0       (rf_rd0),
        .src1       (pc),
        .sel        (alu_src0_sel),
        .res        (alu_src0)
    );

    MUX_2 #(.WIDTH(32)) alu_mux1 (
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

    SLU slu (
        .addr       (alu_res),
        .dmem_access(dmem_access),
        .rd_in      (dmem_rd_in),
        .wd_in      (dmem_wd_in),
        .rd_out     (dmem_rd_out),
        .wd_out     (dmem_wd_out)
    );

    assign dmem_wd_in = rf_rd1;
    
    assign imem_raddr = pc;
    assign inst = imem_rdata;

    assign dmem_addr = alu_res;
    assign dmem_wdata = dmem_wd_out;
    assign dmem_rd_in = dmem_rdata;

endmodule