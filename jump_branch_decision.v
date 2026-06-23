`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2026 11:06:46
// Design Name: 
// Module Name: jump_branch_decision
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


module jump_branch_decision(
    operand_1, operand_2, zero, neg, less_than, jump_branch, pc_src
    );
    
    parameter size = 32;
    
    input [size-1 : 0] operand_1, operand_2;
    input [2:0] jump_branch;
    input zero, neg, less_than;
    
    output reg pc_src;
    
    always @(*) begin
        if (jump_branch == 3'b010) begin
        pc_src <= 0;   //no branch so pc is just incremented to pc+4 
        end else if (jump_branch == 3'b011) begin
        pc_src <= 1; // PC source is the jump target address
        end else begin
        case (jump_branch)
            3'b000: pc_src <= (zero) ? 1 : 0; // BEQ
            3'b001: pc_src <= (!zero) ? 1 : 0; // BNE
            3'b100: pc_src <= (neg) ? 1 : 0; // BLT  //took unsigned
            3'b101: pc_src <= (!neg || zero) ? 1 : 0; // BGE
            3'b110: pc_src <= (less_than) ? 1 : 0; // BLTU
            3'b111: pc_src <= (!less_than || zero) ? 1 : 0; // BGEU
            default: pc_src <= 0; // Default case
        endcase
    end
end

endmodule
