`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2026 13:58:51
// Design Name: 
// Module Name: data_memory
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


module data_memory(
     address, write_data, read_data, clk, rst, data_size, extension_type, write_enable);
    
    parameter size = 32;
    
    parameter base_addr = 32'h00000000;
    
    parameter mem_size = 2000; // size of instruction memory 1792 MB
    
    input [size-1 : 0] write_data;
    input [size-1 : 0] address;
    input [1:0] data_size;
    input clk, rst, write_enable, extension_type;
    
   
    output reg [size-1 : 0] read_data;
    
    reg [31:0] data_memory [0 : mem_size-1];
    reg [3:0] byte_enable;
    
    integer i;
    
    always @(*) begin
        case (address[1:0])
            0 : byte_enable = 4'b0001;
            1 : byte_enable = 4'b0010;
            2 : byte_enable = 4'b0011;
            3 : byte_enable = 4'b1000;
            default : byte_enable = 4'b0000;
        endcase
     end
     
    always @(posedge clk) begin
    if (write_enable) begin
        case (data_size)
            2'b00: begin
                if (byte_enable[0]) data_memory[(address - base_addr)>>2][7:0]   <= write_data[7:0];
                if (byte_enable[1]) data_memory[(address -  base_addr)>>2][15:8]  <= write_data[7:0];
                if (byte_enable[2]) data_memory[(address -  base_addr)>>2][23:16] <= write_data[7:0];
                if (byte_enable[3]) data_memory[(address -  base_addr)>>2][31:24] <= write_data[7:0];
            end

            2'b01: begin
                if (byte_enable[0]) data_memory[(address -  base_addr)>>2][15:0]  <= write_data[15:0];
                if (byte_enable[2]) data_memory[(address -  base_addr)>>2][31:16] <= write_data[15:0];
            end

            2'b10: begin
                data_memory[(address -  base_addr)>>2] <= write_data;
            end
        endcase
    end
end 
    

always @(*) begin
        case (data_size)
            2'b00: begin
                if (!extension_type) begin
                    // Byte-Sign Extend
                    if (byte_enable[0]) read_data <= {{24{data_memory[address - base_addr][7]}} ,data_memory[address - base_addr][7:0]};
                    if (byte_enable[1]) read_data <= {{24{data_memory[address - base_addr][15]}} ,data_memory[address - base_addr][15:8]};
                    if (byte_enable[2]) read_data <= {{24{data_memory[address - base_addr][23]}} ,data_memory[address - base_addr][23:16]};
                    if (byte_enable[3]) read_data <= {{24{data_memory[address - base_addr][31]}} ,data_memory[address - base_addr][31:24]}; 
                end else begin
                    // Byte-UNSign Extend
                    if (byte_enable[0]) read_data <= {24'h000000 ,data_memory[address - base_addr][7:0]};
                    if (byte_enable[1]) read_data <= {24'h000000 ,data_memory[address - base_addr][15:8]};
                    if (byte_enable[2]) read_data <= {24'h000000 ,data_memory[address - base_addr][23:16]};
                    if (byte_enable[3]) read_data <= {24'h000000 ,data_memory[address - base_addr][31:24]}; 
                end
            end 
            2'b01: begin
                if (!extension_type) begin
                    // Halfword-Sign Extend
                    if (byte_enable[0]) read_data <= {{16{data_memory[address - base_addr][15]}} ,data_memory[address - base_addr][15:0]};
                    if (byte_enable[2]) read_data <= {{16{data_memory[address - base_addr][31]}} ,data_memory[address - base_addr][31:16]}; 
                    
                end else begin
                    // Halfword-Zero Extend
                    if (byte_enable[0]) read_data <= {16'h0000 ,data_memory[address - base_addr][15:0]};
                    if (byte_enable[2]) read_data <= {16'h0000 ,data_memory[address -base_addr][31:16]}; 
                end
            end
            2'b10: read_data <= data_memory[address - base_addr]; // Word
            default: read_data <= 0;
        endcase
    end

endmodule
