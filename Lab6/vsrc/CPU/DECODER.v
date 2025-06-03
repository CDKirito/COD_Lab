module DECODER (
    input                   [31 : 0]            inst,

    output reg              [ 4 : 0]            alu_op,
    output reg              [31 : 0]            imm,

    output reg              [ 4 : 0]            rf_ra0,
    output reg              [ 4 : 0]            rf_ra1,
    output reg              [ 4 : 0]            rf_wa,
    output reg              [ 0 : 0]            rf_we,

    output reg              [ 0 : 0]            alu_src0_sel,
    output reg              [ 0 : 0]            alu_src1_sel,

    output reg              [ 3 : 0]            dmem_access,    // 访存类型
    output reg              [ 0 : 0]            dmem_we,        // 访存写使能
    output reg              [ 1 : 0]            rf_wd_sel,      // rgf 写入数据选择
    output reg              [ 3 : 0]            br_type         // 分支类型
);

    // 指令类型
    `define R_OP            7'b0110011      // R 型运算指令
    `define I_OP            7'b0010011      // I 型运算指令
    `define LUI             7'b0110111      // U 型 LUI 指令
    `define AUIPC           7'b0010111      // U 型 AUIPC 指令
    `define LOAD            7'b0000011      // I 型加载指令
    `define STORE           7'b0100011      // S 型存储指令
    `define BRANCH          7'b1100011      // B 型分支指令
    `define JALR            7'b1100111      // I 型 JALR 指令
    `define JAL             7'b1101111      // J 型 JAL 指令

    // ALU 操作码
    `define ADD                 5'B00000    
    `define SUB                 5'B00010   
    `define SLT                 5'B00100
    `define SLTU                5'B00101
    `define AND                 5'B01001
    `define OR                  5'B01010
    `define XOR                 5'B01011
    `define SLL                 5'B01110   
    `define SRL                 5'B01111    
    `define SRA                 5'B10000  
    `define SRC0                5'B10001
    `define SRC1                5'B10010

    // 分支指令类型
    `define BR_JALR             4'b0001
    `define BR_JAL              4'b0010
    `define BR_BEQ              4'b0011
    `define BR_BNE              4'b0100
    `define BR_BLT              4'b0101
    `define BR_BGE              4'b0110
    `define BR_BLTU             4'b0111
    `define BR_BGEU             4'b1000

    // 访存类型
    `define LB                  4'b0000     // Load Byte
    `define LH                  4'b0001     // Load Halfword
    `define LW                  4'b0010     // Load Word
    `define LBU                 4'b0011     // Load Byte Unsigned
    `define LHU                 4'b0100     // Load Halfword Unsigned
    `define SB                  4'b0101     // Store Byte    
    `define SH                  4'b0110     // Store Halfword    
    `define SW                  4'b0111     // Store Word
    
    // RISC-V instruction fields
    wire [6 : 0] opcode = inst[6 : 0];       // Opcode
    wire [4 : 0] rd     = inst[11 : 7];      // Destination register
    wire [2 : 0] funct3 = inst[14 : 12];     // Function 3
    wire [4 : 0] rs1    = inst[19 : 15];     // Source register 1
    wire [4 : 0] rs2    = inst[24 : 20];     // Source register 2
    wire [6 : 0] funct7 = inst[31 : 25];     // Function 7

    // Immediate extraction
    wire [31 : 0] imm_i = {{20{inst[31]}}, inst[31:20]};                // I-type immediate
    wire [31 : 0] imm_u = {inst[31:12], 12'b0};                         // U-type immediate
    wire [31 : 0] imm_shamt = {26'b0, inst[25:20]};                     // Shift amount for immediate instructions
    wire [31 : 0] imm_b = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0}; // B-type immediate
    wire [31 : 0] imm_j = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0}; // J-type immediate
    wire [31 : 0] imm_s = {{20{inst[31]}}, inst[31:25], inst[11:7]};    // S-type immediate

    always @(*) begin
        alu_op       = 5'b0;
        imm          = 32'b0;
        rf_ra0       = 5'b0;
        rf_ra1       = 5'b0;
        rf_wa        = 5'b0;
        rf_we        = 1'b0;
        alu_src0_sel = 1'b0;
        alu_src1_sel = 1'b0;
        dmem_access  = 4'b0;
        dmem_we      = 1'b0;
        rf_wd_sel    = 2'b0;
        br_type      = 4'b0;

        case (opcode)
            `R_OP: begin
                rf_ra0       = rs1;
                rf_ra1       = rs2;
                rf_wa        = rd;
                rf_we        = 1'b1;
                alu_src0_sel = 1'b0; // Use rs1
                alu_src1_sel = 1'b0; // Use rs2
                rf_wd_sel    = 2'b01;
                case ({funct7, funct3})
                    10'b0000000000: alu_op = `ADD;  // ADD
                    10'b0100000000: alu_op = `SUB;  // SUB
                    10'b0000000010: alu_op = `SLT;  // SLT
                    10'b0000000011: alu_op = `SLTU; // SLTU
                    10'b0000000111: alu_op = `AND;  // AND
                    10'b0000000110: alu_op = `OR;   // OR
                    10'b0000000100: alu_op = `XOR;  // XOR
                    10'b0000000001: alu_op = `SLL;  // SLL
                    10'b0000000101: alu_op = `SRL;  // SRL
                    10'b0100000101: alu_op = `SRA;  // SRA
                    default:        alu_op = 5'b11111; // Undefined
                endcase
            end

            `I_OP: begin
                rf_ra0       = rs1;
                rf_wa        = rd;
                rf_we        = 1'b1;
                alu_src0_sel = 1'b0; // Use rs1
                alu_src1_sel = 1'b1; // Use immediate
                imm          = imm_i;
                rf_wd_sel    = 2'b01;
                case (funct3)
                    3'b000: alu_op = `ADD;   // ADDI
                    3'b010: alu_op = `SLT;   // SLTI
                    3'b011: alu_op = `SLTU;  // SLTIU
                    3'b111: alu_op = `AND;   // ANDI
                    3'b110: alu_op = `OR;    // ORI
                    3'b100: alu_op = `XOR;   // XORI
                    3'b001: begin            // SLLI
                        if (imm_shamt[5] == 1'b0) begin
                            alu_op = `SLL;
                            imm    = imm_shamt;
                        end else begin
                            alu_op = 5'b11111;
                        end
                    end
                    3'b101: begin
                        if (imm_shamt[5] == 1'b0) begin
                            imm = imm_shamt;
                            if (funct7 == 7'b0000000)
                                alu_op = `SRL;   // SRLI
                            else if (funct7 == 7'b0100000)
                                alu_op = `SRA;   // SRAI
                            else
                                alu_op = 5'b11111;
                        end else begin
                            alu_op = 5'b11111;
                        end 
                    end

                    default: alu_op = 5'b11111;
                endcase
            end

            `LUI: begin
                rf_wa        = rd;
                rf_we        = 1'b1;
                alu_src0_sel = 1'b1; // Use PC
                alu_src1_sel = 1'b1; // Use immediate
                imm          = imm_u;
                alu_op       = `SRC1;
                rf_wd_sel    = 2'b01;
            end

            `AUIPC: begin
                rf_wa        = rd;
                rf_we        = 1'b1;
                alu_src0_sel = 1'b1; // Use PC
                alu_src1_sel = 1'b1; // Use immediate
                imm          = imm_u;
                alu_op       = `ADD;
                rf_wd_sel    = 2'b01;
            end

            `LOAD: begin
                rf_ra0       = rs1;
                rf_wa        = rd;
                rf_we        = 1'b1;
                alu_src0_sel = 1'b0; // Use rs1
                alu_src1_sel = 1'b1; // Use immediate
                imm          = imm_i;
                alu_op       = `ADD;
                rf_wd_sel    = 2'b10;
                case (funct3)
                    3'b000: dmem_access = `LB;
                    3'b001: dmem_access = `LH;
                    3'b010: dmem_access = `LW;
                    3'b100: dmem_access = `LBU;
                    3'b101: dmem_access = `LHU;
                    default: dmem_access = 4'b1111;
                endcase
            end

            `STORE: begin
                rf_ra0       = rs1;
                rf_ra1       = rs2;
                alu_src0_sel = 1'b0; // Use rs1
                alu_src1_sel = 1'b1; // Use immediate
                imm          = imm_s;
                alu_op       = `ADD;
                dmem_we      = 1'b1;
                case (funct3)
                    3'b000: dmem_access = `SB;
                    3'b001: dmem_access = `SH;
                    3'b010: dmem_access = `SW;
                    default: dmem_access = 4'b1111;
                endcase
            end

            `BRANCH: begin
                rf_ra0       = rs1;
                rf_ra1       = rs2;
                alu_src0_sel = 1'b1; // Use PC
                alu_src1_sel = 1'b1; // Use immediate
                imm          = imm_b;
                alu_op       = `ADD;
                case (funct3)
                    3'b000: br_type = `BR_BEQ;
                    3'b001: br_type = `BR_BNE;
                    3'b100: br_type = `BR_BLT;
                    3'b101: br_type = `BR_BGE;
                    3'b110: br_type = `BR_BLTU;
                    3'b111: br_type = `BR_BGEU;
                    default: br_type = 4'b1111;
                endcase
            end

            `JALR: begin
                rf_ra0       = rs1;
                rf_wa        = rd;
                rf_we        = 1'b1;
                alu_src0_sel = 1'b0; // Use rs1
                alu_src1_sel = 1'b1; // Use immediate
                imm          = imm_i;
                alu_op       = `ADD;
                br_type      = `BR_JALR;
                rf_wd_sel    = 2'b00;
            end

            `JAL: begin
                rf_wa        = rd;
                rf_we        = 1'b1;
                alu_src0_sel = 1'b1; // Use PC
                alu_src1_sel = 1'b1; // Use immediate
                imm          = imm_j;
                alu_op       = `ADD;
                br_type      = `BR_JAL;
                rf_wd_sel    = 2'b00;
            end
            default: begin
                rf_ra0       = 5'b0;
                rf_ra1       = 5'b0;
                rf_wa        = 5'b0;
                rf_we        = 1'b0;
                alu_src0_sel = 1'b0;
                alu_src1_sel = 1'b0;
                dmem_access  = 4'b0000;
                dmem_we      = 1'b0;
                rf_wd_sel    = 2'b00;
                br_type      = 4'b0000;
            end
        endcase
    end

endmodule