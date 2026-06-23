`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2026 05:18:04
// Design Name: 
// Module Name: instruction_memory
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
// ********************SUMMARY***************
// This is like a instruction memory from where the instructions are fetched based on the 
// current pc value. This is used in the IF stage of pipeline
// the pc uses byte adressing i.e, 0,4,8,... but the mem locations are indexed 0,1,2... so we do >>2 for instr mem access
//*******************************************
//////////////////////////////////////////////////////////////////////////////////



module instruction_memory(
    instruction,address
    );
    parameter SIZE = 32;
    parameter BASE_ADDRESS = 32'h00000000;
    parameter mem_size = 2000; // size of instruction memory 8KB so 2000*32 bits ie 2000*4bytes i.e, 8KB
    
    input [SIZE-1 : 0] address;
    output [SIZE-1 : 0] instruction;
    
    //memory is like each word is 32 bit long and there are 2000 memory locations
    reg [31:0] mem [0 : mem_size-1];
    
    //readmemh reads the memory contents from a hexadecimal text file and load them into memory array
    initial begin
    $readmemh("instr_mem.mem",mem);
    end
    
    assign instruction = mem[address - BASE_ADDRESS];
endmodule
