`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2026 19:33:14
// Design Name: 
// Module Name: hazard
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


module hazard(
    read_address_1_D, read_address_2_D, jump_branch_D, read_address_1_E, read_address_2_E, write_address_E, pc_src_E, result_src_E, jump_branch_E, pc_src_predection_E,
fall_through_address, branch_addresss, write_address_M, reg_write_M,write_address_W, reg_write_W,
stall_F, stall_D, flush_D, flush_E, forward_1_E, forward_2_E ,pc_correct_src, correct_address, pc_src_predection, rst, clk
    );
    
    input [4:0] read_address_1_D, read_address_2_D, read_address_1_E, read_address_2_E, write_address_E, write_address_M, write_address_W;
    input [31:0] fall_through_address; //pc next is pc plus 4
    input [31:0] branch_addresss;
    input [2:0] jump_branch_D, jump_branch_E;
    input [1:0] result_src_E;
    input reg_write_M, reg_write_W;
    input pc_src_E, pc_src_predection_E;
    input clk, rst;
    
    output reg [31:0] correct_address;
    output reg [1:0] forward_1_E, forward_2_E;
    output reg flush_D, flush_E;
    output reg pc_correct_src, pc_src_predection;
    output reg stall_F, stall_D;
    
    reg [1:0] branch_predection;
    
    always @(*) begin
         if ((((read_address_1_E == write_address_M) & reg_write_M)) & (read_address_1_E != 0)) begin
            forward_1_E <= 2'b10; // Forward data from memory stage
        end else if ((((read_address_1_E == write_address_W) & reg_write_W)) & (read_address_1_E != 0)) begin
            forward_1_E <= 2'b01; // Forward data from writeback stage
        end else begin
            forward_1_E <= 2'b00; // No data forwarding
        end
    end
    
    always @(*) begin
        if (((read_address_2_E == write_address_M) & reg_write_M) & (read_address_2_E != 0)) begin
            forward_2_E <= 2'b10; // Forward data from memory stage
        end else if (((read_address_2_E == write_address_W) & reg_write_W) & (read_address_2_E != 0)) begin
            forward_2_E <= 2'b01; // Forward data from writeback stage
        end else begin
            forward_2_E <= 2'b00; // No data forwarding
        end
    end
    
    // Stall the fetch stage if there is a data hazard
    always @(*) begin
        if (rst) begin
            stall_F <= 0;
            stall_D <= 0;
        end else if (((read_address_1_D == write_address_E) | (read_address_2_D == write_address_E)) & (result_src_E[0])) begin
            stall_F <= 1;
            stall_D <= 1;
        end else begin
            stall_F <= 0;
            stall_D <= 0;
        end
    end
    
    always @(*) begin
        if (pc_src_E) begin
            correct_address <= branch_addresss;
        end else begin
            correct_address <= fall_through_address;
        end
    end
    
    // PC source prediction
    always @(*) begin
        if (rst) begin
            pc_src_predection <= 0;
        end else if (jump_branch_D != 3'b010 & branch_predection[1]) begin
            pc_src_predection <= 1;
        end else begin
            pc_src_predection <= 0;
        end
    end

    // Branch prediction update
    always @(posedge clk) begin
        if (rst) begin
            branch_predection <= 2'b11;
        end else if (jump_branch_E != 3'b010) begin
            if (pc_src_E) begin
                case (branch_predection)
                    2'b00, 2'b01, 2'b10:  branch_predection <= branch_predection + 1;
                    default: branch_predection <= branch_predection;
                endcase
            end else begin
            case (branch_predection)
                2'b11, 2'b01, 2'b10:  branch_predection <= branch_predection - 1;
                default: branch_predection <= branch_predection;
            endcase
        end 
        end
    end

    // Flush signals
    always @(*) begin
        if (rst) begin
            flush_D <= 1;
            flush_E <= 1;
            pc_correct_src <= 0;
        end else if (jump_branch_E != 3'h2) begin
            if (pc_src_E != pc_src_predection_E) begin
                flush_D <= 1;
                flush_E <= 1;
                pc_correct_src <= 1;
            end else begin
                flush_D <= 0;
                flush_E <= 0;
                pc_correct_src <= 0;
            end
        end else begin
                flush_D <= 0;
                flush_E <= 0;
                pc_correct_src <= 0;
            end
        if (((read_address_1_D == write_address_E) | (read_address_2_D == write_address_E)) & (result_src_E[0])) begin
            flush_E <= 1;
        end
    end


     
endmodule
