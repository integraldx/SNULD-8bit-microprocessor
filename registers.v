`timescale 1ns/1ps

module registers
(
    input CLK,
    input areset,
    input [1:0] selector_a,
    input [1:0] selector_b,

    input write_bit,
    input [1:0] selector_e,
    input [7:0] data_in,

    output [7:0] data_out_a,
    output [7:0] data_out_b
);
    reg [7:0] regs[3:0];

    assign data_out_a = regs[selector_a];
    assign data_out_b = regs[selector_b];
    
    initial begin
        regs[0] = 0;
        regs[1] = 0;
        regs[2] = 0;
        regs[3] = 0;
    end

    always @ (posedge CLK)
    begin
        if (areset)
        begin
            regs[0] = 0;
            regs[1] = 0;
            regs[2] = 0;
            regs[3] = 0;
        end
        else if (write_bit)
        begin
            regs[selector_e] = data_in;
        end
    end
endmodule
