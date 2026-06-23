`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2026 14:45:22
// Design Name: 
// Module Name: memory_writeback_register
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


module memory_writeback_register(
    result_M, write_address_M, pc_plus_four_M, read_data_M, result_src_M, reg_write_M, extended_imm_M,
 result_W, write_address_W, pc_plus_four_W, read_data_W, result_src_W, reg_write_W, extended_imm_W, clk
    );
    
    input [31:0] result_M, pc_plus_four_M, read_data_M ,extended_imm_M;
    input [4:0] write_address_M;
    input [1:0] result_src_M;
    input reg_write_M;
    input clk;
    
    output reg [31:0] result_W, pc_plus_four_W, read_data_W, extended_imm_W;
    output reg [4:0] write_address_W;
    output reg [1:0] result_src_W;
    output reg reg_write_W;

    always @(posedge clk) begin
        // If enable is high, set the output to the input value
        result_W <= result_M;
        write_address_W <= write_address_M;
        pc_plus_four_W <= pc_plus_four_M;
        read_data_W <= read_data_M;
        result_src_W <= result_src_M;
        reg_write_W <= reg_write_M;
        extended_imm_W <= extended_imm_M;
    end
    
endmodule
