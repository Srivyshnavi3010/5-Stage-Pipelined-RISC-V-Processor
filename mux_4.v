`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2026 19:30:09
// Design Name: 
// Module Name: mux_4
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


module mux_4(
        operand_1, operand_2, operand_3, operand_4, select, result
    );
    
   parameter size = 32; 
   
    input [size-1:0] operand_1, operand_2, operand_3, operand_4;  
    input [1:0] select;
    
    output reg [size-1:0] result;
    
    always @(*) begin
        case (select)
            2'b00: result = operand_1;
            2'b01: result = operand_2;
            2'b10: result = operand_3;
            2'b11: result = operand_4;
            default: result = 32'hxxxxxxxx;
        endcase
    end
endmodule
