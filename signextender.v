`timescale 1ns/1ps

module signextender
(
    input [5:0] data_in,
    input is_6bits,
    output [7:0] data_out
);
    assign data_out = is_6bits ? 
        (data_in[5] ? {2'b11, data_in} : {2'b00, data_in}) : 
        (data_in[1] ? {2'b111111, data_in[1:0]} : {2'b111111, data_in[1:0]});
            
endmodule
