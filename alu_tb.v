`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:46:45 06/07/2019
// Design Name:   alu
// Module Name:   /csehome/jmh1214/Documents/SNULD-8bit-microprocessor/alu_tb.v
// Project Name:  SNULD-8bit-microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu_tb;

	// Inputs
	reg negate;
	reg [7:0] val_a;
	reg [7:0] val_b;

	// Outputs
	wire [7:0] val_e;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.negate(negate), 
		.val_a(val_a), 
		.val_b(val_b), 
		.val_e(val_e)
	);

	initial begin
		// Initialize Inputs
		negate = 0;
		val_a = 0;
		val_b = 0;

		// Wait 100 ns for global reset to finish
		#100;
		negate = 1;
		val_a = 1;
		val_b = 2;
        
		// Add stimulus here

	end
      
endmodule

