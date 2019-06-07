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

    // Control bits
	wire pc_write;
	wire register_write;
    wire register_from_memory;
	wire alu_negate;
    wire val_a_imm_selection;
    wire val_b_pc_selection;
    wire reg_num_shift;

    // Data bits
	wire [7:0] alu_result;
	wire [7:0] val_a;
	wire [7:0] val_b;
    wire [7:0] val_e; // alu calculation result
    wire [7:0] val_i; // immidiate value

	wire [7:0] reg_a;
	wire [7:0] reg_b;
    wire [7:0] reg_e;

	controller controller_0(
        .mode(imem_data[7:6]),
        .opcode(imem_data[5:4]),
		.register_write(register_write),
        .memory_write(dmem_write),
		.pc_write(pc_write),
        .memory_to_register(register_from_memory),
		.alu_negation(alu_negate),
        .val_a_imm_selection(val_a_imm_selection),
        .val_b_pc_selection(val_b_pc_selection),
        .reg_num_shift(reg_num_shift)
	);

	pc pc_0(
		.CLK(clk),
		.areset(areset),
		.pc_write(pc_write),
        .addr_in(val_e),
		.addr_out(imem_addr)
	);

	registers registers_0(
		.CLK(clk),
		.areset(areset),
		.selector_a(reg_num_shift ? imem_data[5:4] : imem_data[3:2]),
		.selector_b(reg_num_shift ? imem_data[3:2] : imem_data[1:0]),
		.write_bit(register_write),
		.selector_e(reg_num_shift ? imem_data[5:4] : imem_data[3:2]),
		.data_in(reg_e),
		.data_out_a(reg_a),
		.data_out_b(reg_b)
	);

	alu alu_0(
		.negate(alu_negate),
		.val_a(val_a),
		.val_b(val_b),
		.val_e(val_e)
	);

    signextender ext(
        .data_in(imem_data[5:0]),
        .is_6bits(pc_write),
        .data_out(val_i)
    );

    assign val_a = val_a_imm_selection ? val_i : reg_a;
    assign val_b = val_b_pc_selection ? imem_addr : reg_b;
    assign reg_e = (register_from_memory ? dmem_read_data : val_e);
    assign dmem_write_data = reg_a;
    assign dmem_addr = val_e;
endmodule

