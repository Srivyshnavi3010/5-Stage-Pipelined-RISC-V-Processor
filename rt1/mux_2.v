`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2026 19:24:29
// Design Name: 
// Module Name: mux_2
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
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_2(
    operand_1, operand_2, select, result
    );
    parameter size = 32;
    
    input [size-1 : 0] operand_1, operand_2;
    input select;
    
    output [size-1 : 0] result;
    
    assign result = select ? operand_2 : operand_1;
endmodule
