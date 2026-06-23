`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.06.2026 19:19:01
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    read_addr1, read_addr2, write_addr, write_data, write_en, read_data1, read_data2, clk, reset
    );
    //size of register file is 32 bits total of 32 registers each of 32-bit wide
    parameter size = 32;
    
    input [size-1 : 0] write_data;
    input [4 : 0] read_addr1, read_addr2, write_addr;
    input clk, write_en, reset;
    
    output [size-1 : 0] read_data1, read_data2;
    
    reg [size-1 : 0] register_file [0: size-1];
    
    integer i;
    
    
    always @(posedge clk) begin
        if(reset) begin     //if reset is high we initialise all reg to zero
        for(i=0;i<=size-1;i=i+1) begin
            register_file[i] <=0;
        end
        // x2 is stack pointer so after initialising we set it
        register_file[2] <= 32'h00000500;
        end
        else if (write_en) begin
        //write enable high we write data to the specified reg
        //x0 must always be 0
        if(write_addr == 5'b00000) begin
        register_file[write_addr] <= 0;
        end else begin
        register_file[write_addr] <= write_data;
        end
        end
     end
     
     assign read_data1 = register_file[read_addr1];
     assign read_data2 = register_file[read_addr2];
 
        
        
        
endmodule
