`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2026 19:27:02
// Design Name: 
// Module Name: mux_3
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


module mux_3(
    operand_1, operand_2, operand_3, select, result
    );
    parameter size = 32;
    
    input [size-1 : 0] operand_1, operand_2, operand_3;
    input [1:0] select;
    
    output reg [size-1 : 0] result;
    
    always @(*) begin
        case (select)
            2'b00 : result = operand_1;
            2'b01 : result = operand_2;
            2'b10 : result = operand_3;
            default : result = operand_1;
         endcase
         end
    
    
endmodule
