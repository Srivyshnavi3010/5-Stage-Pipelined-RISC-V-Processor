`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2026 11:20:23
// Design Name: 
// Module Name: execute_memory_register
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


module execute_memory_register(
        result_E, write_data_E, write_address_E, pc_plus_four_E, result_src_E, mem_write_E, reg_write_E, extended_imm_E, data_size_E, extension_type_E,
 result_M, write_data_M, write_address_M, pc_plus_four_M, result_src_M, mem_write_M, reg_write_M, extended_imm_M, data_size_M, extension_type_M, clk
        );

    input [31:0] result_E, write_data_E, pc_plus_four_E, extended_imm_E;
    input [4:0] write_address_E;
    input [1:0] result_src_E, data_size_E;
    input mem_write_E, reg_write_E, extension_type_E;
    input clk;
    
    output reg [31:0] result_M, write_data_M, pc_plus_four_M, extended_imm_M;
    output reg [4:0] write_address_M;
    output reg [1:0] result_src_M, data_size_M;
    output reg mem_write_M, reg_write_M, extension_type_M;
    
    
    always @(posedge clk) begin
        // If enable is high then set the output to the input value
        result_M <= result_E;
        write_data_M <= write_data_E;
        write_address_M <= write_address_E;
        pc_plus_four_M <= pc_plus_four_E;
        result_src_M <= result_src_E;
        mem_write_M <= mem_write_E;
        reg_write_M <= reg_write_E;
        extended_imm_M <= extended_imm_E;
        data_size_M <= data_size_E;
        extension_type_M <= extension_type_E;
    end


endmodule
