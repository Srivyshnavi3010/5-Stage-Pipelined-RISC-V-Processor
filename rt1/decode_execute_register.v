`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2026 09:31:02
// Design Name: 
// Module Name: decode_execute_register
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

/** all the control and data signals are moved from decode stage to execute stage
if clr is high ie flush_e all outputs are reset to default vlues 
this flush is used after a branch misprediction or excpetion

orelse all thr outputs are updated with current inputs from the decdode stage **/
module decode_execute_register (read_data_1_D, read_data_2_D, pcD, read_address_1_D, read_address_2_D, write_address_D, extended_imm_D, pc_plus_four_D, 
jump_branch_D, result_src_D, mem_write_D, alu_control_D, alu_src_D, reg_write_D, data_size_D, extension_type_D, pc_src_predection_D,
read_data_1_E, read_data_2_E, pcE, read_address_1_E, read_address_2_E, write_address_E, extended_imm_E, pc_plus_four_E,
jump_branch_E, result_src_E, mem_write_E, alu_control_E, alu_src_E, reg_write_E, data_size_E, extension_type_E, pc_src_predection_E, clk, CLR, EN);
    
    
    
    input [31:0] read_data_1_D, read_data_2_D, pcD, extended_imm_D, pc_plus_four_D;
    input [4:0] read_address_1_D, read_address_2_D, write_address_D;
    input [4:0] alu_control_D;
    input [2:0] jump_branch_D;
    input [1:0] result_src_D, alu_src_D, data_size_D;
    input reg_write_D, extension_type_D, mem_write_D, pc_src_predection_D;
    input clk, CLR, EN;
    
    output reg [31:0] read_data_1_E, read_data_2_E, pcE, extended_imm_E, pc_plus_four_E;
    output reg [4:0] alu_control_E, read_address_1_E, read_address_2_E, write_address_E;
    output reg [2:0] jump_branch_E;
    output reg [1:0] result_src_E, alu_src_E, data_size_E;
    output reg reg_write_E, extension_type_E, mem_write_E, pc_src_predection_E;
    
    
    always @(posedge clk) begin
        if(CLR) begin
            //if clr is high we set the output to zero
             read_data_1_E <= 32'h00000000;
            read_data_2_E <= 32'h00000000;
            pcE <= 32'h00000000;
            read_address_1_E <= 5'h00;
            read_address_2_E <= 5'h00;
            write_address_E <= 5'h00;
            extended_imm_E <= 32'h00000000;
            pc_plus_four_E <= 32'h00000000;
            jump_branch_E <= 3'h2;
            result_src_E <= 2'b00;
            mem_write_E <= 1'b0;
            alu_control_E <= 5'h00;
            alu_src_E <= 2'b00;
            reg_write_E <= 1'b0;
            data_size_E <= 2'b00;
            extension_type_E <= 1'b0;
            pc_src_predection_E <= 1'b0;
            
         end else begin
            //if en is high we set all the outputs to the input value
            read_data_1_E <= read_data_1_D;
            read_data_2_E <= read_data_2_D;
            pcE <= pcD;
            read_address_1_E <= read_address_1_D;
            read_address_2_E <= read_address_2_D;
            write_address_E <= write_address_D;
            extended_imm_E <= extended_imm_D;
            pc_plus_four_E <= pc_plus_four_D;
            jump_branch_E <= jump_branch_D;
            result_src_E <= result_src_D;
            mem_write_E <= mem_write_D;
            alu_control_E <= alu_control_D;
            alu_src_E <= alu_src_D;
            reg_write_E <= reg_write_D;
            data_size_E <= data_size_D;
            extension_type_E <= extension_type_D;
            pc_src_predection_E <= pc_src_predection_D;
            end
          end
          
            

endmodule
