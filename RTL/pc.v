`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2026 17:38:15
// Design Name: 
// Module Name: pc
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
// ****************************SUMMARY**************************
// On reset, PC is initialized to the base instruction address(0x00000000), so instruction execution starts from the beginning.
// Input 'in'(input address) contains the next PC VAlue to be loaded
// EN connected to stall_F in hazard control unit
    //EN=0 PC updates normally with next instr address
    //EN=1 PC holds its current value stalling the fetch stage during hazards such as load-use dependencies.
// PC updates on rising edge of the clk.
//****************************************************** 
//////////////////////////////////////////////////////////////////////////////////


module pc(
    in,out,clk,reset,EN
    );
    parameter SIZE = 32;  //size of the instruction ois 32 bits
    parameter BASE_INSTR_ADDRESS = 32'h00000000;
    input [SIZE-1 : 0] in;
    input clk,reset,EN;
    output reg[SIZE-1 : 0] out;
    
    //if reset is 0 then start from the base address and if not then if en is 1 then we have to stay at the ssame pc value and if en is 0 then pc increments ie it gets the in value
    always @(posedge clk) begin
        if(reset) begin
        out <= BASE_INSTR_ADDRESS;
        end
        else if (EN == 0) begin
        out <= in;
        end
        else out <= out; //case when en is 1
     end
endmodule
