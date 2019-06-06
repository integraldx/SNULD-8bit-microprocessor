`timescale 1ns/1ps

module alu
(
    input negate,
    input [7:0] val_a,
    input [7:0] val_b,
    output [7:0] val_e
);
    assign val_e = negate ? val_a - val_b : val_a + val_b;
endmodule
