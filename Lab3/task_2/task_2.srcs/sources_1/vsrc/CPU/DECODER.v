module DECODER (
    input                   [31 : 0]            inst,

    output reg              [ 4 : 0]            alu_op,
    output reg              [31 : 0]            imm,

    output reg              [ 4 : 0]            rf_ra0,
    output reg              [ 4 : 0]            rf_ra1,
    output reg              [ 4 : 0]            rf_wa,
    output reg              [ 0 : 0]            rf_we,

    output reg              [ 0 : 0]            alu_src0_sel,
    output reg              [ 0 : 0]            alu_src1_sel
);

    `define R_TYPE            7'b0110011
    `define I_TYPE            7'b0010011
    `define LUI               7'b0110111
    `define AUIPC             7'b0010111

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

    always @(*) begin
        // Default values
        alu_op       = 5'b0;
        imm          = 32'b0;
        rf_ra0       = 5'b0;
        rf_ra1       = 5'b0;
        rf_wa        = 5'b0;
        rf_we        = 1'b0;
        alu_src0_sel = 1'b0;
        alu_src1_sel = 1'b0;

        case (opcode)
            `R_TYPE: begin // R-type instructions
                rf_ra0       = rs1;
                rf_ra1       = rs2;
                rf_wa        = rd;
                rf_we        = 1'b1;
                alu_src0_sel = 1'b0; // Use rs1
                alu_src1_sel = 1'b0; // Use rs2
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
            `I_TYPE: begin // I-type instructions
                rf_ra0       = rs1;
                rf_wa        = rd;
                rf_we        = 1'b1;
                alu_src0_sel = 1'b0; // Use rs1
                alu_src1_sel = 1'b1; // Use immediate
                imm          = imm_i;
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
                            alu_op = 5'b11111; // Undefined
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
                                alu_op = 5'b11111; // Undefined
                        end else begin
                            alu_op = 5'b11111; // Undefined
                        end 
                    end
                    default: alu_op = 5'b11111; // Undefined
                endcase
            end
            `LUI: begin // U-type (LUI)
                rf_wa        = rd;
                rf_we        = 1'b1;
                alu_src0_sel = 1'b1; // Use PC
                alu_src1_sel = 1'b1; // Use immediate
                imm          = imm_u;
                alu_op       = `SRC1;
            end
            `AUIPC: begin // U-type (AUIPC)
                rf_wa        = rd;
                rf_we        = 1'b1;
                alu_src0_sel = 1'b1; // Use PC
                alu_src1_sel = 1'b1; // Use immediate
                imm          = imm_u;
                alu_op       = `ADD;
            end
            default: begin
                // Undefined instruction
                alu_op       = 5'b11111;
            end
        endcase
    end

endmodule