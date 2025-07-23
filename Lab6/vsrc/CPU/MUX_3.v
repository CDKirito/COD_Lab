module MUX_3 # (
    parameter               WIDTH                   = 32
)(
    input                   [WIDTH-1 : 0]           src0, src1, src2,
    input                   [      1 : 0]           sel,

    output                  [WIDTH-1 : 0]           res
);

    assign res = sel == 2'b00 ? src0 :
                 sel == 2'b01 ? src1 :
                 sel == 2'b10 ? src2 : 0;

endmodule