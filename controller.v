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
    output val_b_imm_selection
);
    assign pc_write = (mode == 2'b00 ? 1 : 0);
    assign memory_write = (mode == 2'b10 ? 1 : 0);
    assign memory_to_register = (mode == 2'b01 ? 1 : 0);
    assign register_write = (mode == 2'b11 || mode == 2'b01 ? 1 : 0);
    assign alu_negation = (opcode == 2'b10 ? 1 : 0);
    assign val_b_imm_selection = (mode == 2'b10 || mode == 2'b01 ? 1 : 0);
endmodule
