`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2026 10:34:35
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
/** ADD,SUB,SLL(Shift left logical),SLT(Set less than signed),SLTU(set less than unsigned),
XOR, SRL(Shift right logical), SRA(Shift right arithmentic), OR,AND. Default cases set to zero.
FLAGS:
zero: true if subtraction result is zero
neg: true if operand1 is less than operand 2 --signed
less_than : true if operand1 is less tan operand2 -- unsigned **/
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    operand_1,operand_2,zero,neg,less_than,result, ALU_control
    );
    parameter size = 32;
    input signed [size-1 : 0] operand_1, operand_2;
    input [4 : 0] ALU_control;
    
    output reg signed [size-1 : 0] result;
    output zero, neg, less_than;
    
    always @(*) begin
         case (ALU_control)
            5'b00000: result = operand_1 + operand_2; // ADD
            5'b00010: result = operand_1 - operand_2; // SUB
            5'b00100: result = operand_1 << operand_2; // SLL
            5'b01000: result = operand_1 < operand_2 ? 1 : 0; // SLT
            5'b01100: result = $unsigned(operand_1) < $unsigned(operand_2) ? 1 : 0; // SLTU
            5'b10000: result = operand_1 ^ operand_2; // XOR
            5'b10100: result = operand_1 >> operand_2; // SRL
            5'b10110: result = operand_1 >>> operand_2; // SRA
            5'b11000: result = operand_1 | operand_2; // OR
            5'b11100: result = operand_1 & operand_2; // AND
            default: result = 0; // Default case
        endcase
    end
    
    //flags
    assign zero = (operand_1 - operand_2 ==0);
    assign neg = (operand_1 < operand_2);
    assign less_than = ($unsigned(operand_1) < $unsigned(operand_2));
endmodule
