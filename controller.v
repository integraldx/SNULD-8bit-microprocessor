`timescale 1ns/1ps

module controller
(
    input [1:0] mode,
    input [1:0] opcode,
    output register_write,
    output memory_write,
    output pc_write,
    output memory_to_register,
    output alu_negation,
    output val_a_imm_selection,
    output val_b_pc_selection,
    output reg_num_shift
);
    assign pc_write = (mode == 2'b00 ? 1 : 0);
    assign memory_write = (mode == 2'b10 ? 1 : 0);
    assign memory_to_register = (mode == 2'b01 ? 1 : 0);
    assign register_write = ((mode == 2'b11 && opcode != 2'b00) || mode == 2'b01 ? 1 : 0);
    assign alu_negation = (mode == 2'b11 && opcode == 2'b10 ? 1 : 0);
    assign val_a_imm_selection = (mode == 2'b10 || mode == 2'b01 || mode == 2'b00 ? 1 : 0);
    assign val_b_pc_selection = (mode == 2'b00 ? 1 : 0);
    assign reg_num_shift = (mode == 2'b10 || mode == 2'b01 ? 1 : 0);
endmodule
