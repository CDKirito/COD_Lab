`timescale 1ns / 1ps

module REGFILE_tb;

    // Inputs
    reg clk;
    reg [4:0] rf_ra0;
    reg [4:0] rf_ra1;
    reg [4:0] rf_wa;
    reg rf_we;
    reg [31:0] rf_wd;

    // Outputs
    wire [31:0] rf_rd0;
    wire [31:0] rf_rd1;

    // Instantiate the Unit Under Test (UUT)
    REGFILE uut (
        .clk(clk),
        .rf_ra0(rf_ra0),
        .rf_ra1(rf_ra1),
        .rf_wa(rf_wa),
        .rf_we(rf_we),
        .rf_wd(rf_wd),
        .rf_rd0(rf_rd0),
        .rf_rd1(rf_rd1)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Testbench logic
    initial begin
        // Initialize inputs
        rf_ra0 = 0;
        rf_ra1 = 0;
        rf_wa = 0;
        rf_we = 0;
        rf_wd = 0;

        // Wait for global reset
        #10;

        // Test 1: Write to register 1 and verify read (write priority)
        rf_wa = 5'd1;    // Write address
        rf_wd = 32'hDEADBEEF; // Write data
        rf_we = 1;       // Enable write
        rf_ra0 = 5'd1;   // Read address 0 (same as write address)
        #5;              // Wait for half clock period to test combinational logic
        $display("Test 1: rf_rd0 = %h (expected: DEADBEEF)", rf_rd0);

        #5;              // Wait for clock edge
        rf_we = 0;       // Disable write
        #10;             // Wait for read
        $display("Test 1: rf_rd0 after clock = %h (expected: DEADBEEF)", rf_rd0);

        // Test 2: Write to register 2 and verify read
        rf_wa = 5'd2;
        rf_wd = 32'hCAFEBABE;
        rf_we = 1;
        rf_ra1 = 5'd2;   // Read address 1 (same as write address)
        #5;              // Wait for half clock period to test combinational logic
        $display("Test 2: rf_rd1 = %h (expected: CAFEBABE)", rf_rd1);

        #5;              // Wait for clock edge
        rf_we = 0;
        #10;
        $display("Test 2: rf_rd1 after clock = %h (expected: CAFEBABE)", rf_rd1);

        // Test 3: Read from an uninitialized register
        rf_ra0 = 5'd3;   // Read address 0
        #10;
        $display("Test 3: rf_rd0 = %h (expected: 00000000)", rf_rd0);

        // Test 4: Write to register 0 (should be ignored)
        rf_wa = 5'd0;
        rf_wd = 32'hFFFFFFFF;
        rf_we = 1;
        #10;
        rf_we = 0;
        rf_ra0 = 5'd0;   // Read address 0
        #10;
        $display("Test 4: rf_rd0 = %h (expected: 00000000)", rf_rd0);

        // Test 5: Simultaneous read and write to different registers
        rf_wa = 5'd4;
        rf_wd = 32'h12345678;
        rf_we = 1;
        rf_ra0 = 5'd1;   // Read address 0 (different from write address)
        #10;
        $display("Test 5: rf_rd0 = %h (expected: DEADBEEF)", rf_rd0);

        // Finish simulation
        $stop;
    end

endmodule