`timescale 1ns/1ps

module signextender
(
    input [5:0] data_in,
    input isSigned,
    output [7:0] data_out
)
    assign data_out = isSigned & data_in[5] ? {2'b11, data_in} : {2'b00, data_in};
endmodule