`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2026 11:04:25
// Design Name: 
// Module Name: address_calculation
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


module address_calculation(
    pc, imm_extend,branch_jump_address
    );
    
    input [31:0] pc, imm_extend;
    
    output reg [31:0] branch_jump_address;
    
    always @(*) begin
        branch_jump_address = pc + imm_extend;
        end
endmodule
