module TOP (
    input                   [ 0 : 0]            clk,
    input                   [ 0 : 0]            rst,

    input                   [ 0 : 0]            enable,
    input                   [ 4 : 0]            in,
    input                   [ 1 : 0]            ctrl,

    output                  [ 3 : 0]            seg_data,
    output                  [ 2 : 0]            seg_an
);

    reg  [31:0] alu_src0;
    reg  [31:0] alu_src1;
    reg  [4:0] alu_op;
    wire [31:0] alu_res;
    reg  [31:0] output_data;

    ALU alu (
        .alu_src0(alu_src0),
        .alu_src1(alu_src1),
        .alu_op(alu_op),
        .alu_res(alu_res)
    );

    Segment segment (
        .clk(clk),
        .rst(rst),
        .output_data(output_data),
        .seg_data(seg_data),
        .seg_an(seg_an)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            alu_src0 <= 32'b0;
            alu_src1 <= 32'b0;
            alu_op <= 5'b0;
            output_data <= 32'b0;
        end else if (enable) begin
            case (ctrl)
                2'b00: begin
                    alu_op <= in;
                end
                2'b01: begin
                    alu_src0 <= {{27{in[4]}}, in};
                end
                2'b10: begin
                    alu_src1 <= {{27{in[4]}}, in};
                end
                2'b11: begin
                    output_data <= alu_res;
                end
                default: begin
                    alu_op <= 5'b0;
                end
            endcase
        end
    end

endmodule