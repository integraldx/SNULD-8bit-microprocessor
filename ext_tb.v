`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:02:30 06/07/2019
// Design Name:   signextender
// Module Name:   /csehome/jmh1214/Documents/SNULD-8bit-microprocessor/ext_tb.v
// Project Name:  SNULD-8bit-microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: signextender
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ext_tb;

	// Inputs
	reg [5:0] data_in;
	reg is_6bits;

	// Outputs
	wire [7:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	signextender uut (
		.data_in(data_in), 
		.is_6bits(is_6bits), 
		.data_out(data_out)
	);

	initial begin
		// Initialize Inputs
		data_in = 0;
		is_6bits = 0;

		// Wait 100 ns for global reset to finish
		#100;
		data_in = 2'b10;
		#100;
        
		// Add stimulus here

	end
      
endmodule

