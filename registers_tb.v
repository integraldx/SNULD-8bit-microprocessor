`timescale 1ns/1ps

module registers_tb
();
    reg CLK = 0;
    reg [1:0] selector_a = 0;
    reg [1:0] selector_b = 0;

    reg write_bit = 0;
    reg [1:0] selector_e = 0;

    reg [7:0] data_in = 0;
    wire [7:0] data_out_a;
    wire [7:0] data_out_b;

    registers uut(
        .CLK(CLK),
        .selector_a(selector_a),
        .selector_b(selector_b),
        .write_bit(write_bit),
        .selector_e(selector_e),
        .data_in(data_in),
        .data_out_a(data_out_a),
        .data_out_b(data_out_b)
        );

    always
    begin
        #5 CLK = ~CLK;
    end

    initial begin
        write_bit = 1;
        data_in = 7;
        selector_b = 1;
        #7;
        write_bit = 0;

        if (data_out_a == 7 && data_out_b == 0)
            $monitor("Register test passed");
        else
            $monitor("Register test failed");
    end
endmodule
