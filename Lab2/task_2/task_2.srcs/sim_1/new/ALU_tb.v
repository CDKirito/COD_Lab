`timescale 1ns / 1ps

module ALU_tb;

    // Inputs
    reg [31:0] alu_src0;
    reg [31:0] alu_src1;
    reg [4:0] alu_op;

    // Outputs
    wire [31:0] alu_res;

    // Instantiate the ALU module
    ALU uut (
        .alu_src0(alu_src0),
        .alu_src1(alu_src1),
        .alu_op(alu_op),
        .alu_res(alu_res)
    );

    // Testbench logic
    initial begin
        // Initialize inputs
        alu_src0 = 0;
        alu_src1 = 0;
        alu_op = 0;

        alu_src0 = 32'hFFFFFFFF;
        alu_src1 = 32'h00000002;
        alu_op = 5'b00000; // ADD
        #10;

        alu_op = 5'b00010; // SUB
        #10;

        alu_op = 5'b00100; // SLT
        #10;

        alu_op = 5'b00101; // SLTU
        #10;

        alu_op = 5'b01001; // AND
        #10;

        alu_op = 5'b01010; // OR
        #10;

        alu_op = 5'b01011; // XOR
        #10;

        alu_op = 5'b01110; // SLL
        #10;

        alu_op = 5'b01111; // SRL
        #10;

        alu_op = 5'b10000; // SRA
        #10;

        alu_op = 5'b10001; // SRC0
        #10;

        alu_op = 5'b10010; // SRC1
        #10;

        alu_op = 5'b11111; // Invalid operation
        #10;

        $finish;
    end

endmodule