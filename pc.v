`timescale 1ns/1ps

module ps
(
    input CLK,
    input areset,
    input write_bit,
    input [7:0] addr_in,
    output [7:0] addr_out
)
    reg [7:0] pc_mem;
    assign addr_out = pc_mem;

    always @ (negedge CLK)
    begin
        if (areset)
        begin
            pc_mem = 0;
        end
        else
        begin
            if (write_bit)
            begin
                pc_mem = addr_in;
            end
            else
            begin
                pc_mem = pc_mem + 1;
            end
        end
    end
endmodule