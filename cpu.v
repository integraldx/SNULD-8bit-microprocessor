`timescale 1ns/1ps

//Machine code layout

/*
Jump:	00 [offset 6b]
Load:	01 [rt] [rs] [off] -> rt = rs[off]
Loading to any register should update tb_data of TB wiring (Handled by TA).

Store: 	10 [rs] [rd] [off] -> rd[off] = rs

Arith:	11 [op] [rd] [rs]
	11 00 NOP
	11 01 ADD	rd += rs
	11 10 SUB	rd -= rs
	11 11 NOP
*/


module cpu	//Do not change top module name or ports.
(
	input	clk,
	input	areset,

	output	[7:0] imem_addr,	//Request instruction memory
	input	[7:0] imem_data,	//Returns 

	output	[7:0] tb_data		//Testbench wiring.
);

	//Data memory and testbench wiring. you may rename them if you like.
	wire dmem_write;
	wire [7:0] dmem_addr, dmem_write_data, dmem_read_data;
	
	//Data memory module in tb.v.
	memory dmem(	.clk(clk), .areset(areset),
			.write(dmem_write), .addr(dmem_addr),
			.write_data(dmem_write_data), .read_data(dmem_read_data));

	assign tb_data = dmem_read_data;
	//Testbench wiring end.

	//Write your code here.
	wire pc_write;
	wire register_write;
	wire alu_negate;
	wire [7:0] alu_result;
	wire [7:0] val_a;
	wire [7:0] val_b;

	controller controller_0(
		.register_write(register_write),
		.pc_write(pc_write),
		.alu_negation(alu_negate),
	);

	pc pc_0(
		.CLK(clk),
		.areset(areset),
		.offset_bit(pc_write),
		.addr_out(imem_addr),
	);

	registers registers_0(
		.CLK(clk),
		.areset(areset),
		.selector_a(imem_data[1:0]),
		.selector_b(imem_data[3:2]),
		.write_bit(register_write),
		.selector_e(imem_data[1:0]),
		.data_in(alu_result),
		.data_out_a(val_a),
		.data_out_b(val_b),
	);

	alu alu_0(
		.negate(alu_negate),
		.val_a(val_a),
		.val_b(val_b),
		.val_e(alu_result)
	);

endmodule

