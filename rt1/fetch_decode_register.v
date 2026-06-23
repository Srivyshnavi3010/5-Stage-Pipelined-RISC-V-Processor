`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2026 06:26:15
// Design Name: 
// Module Name: fetch_decode_register
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
// ***********************SUMMARY**********************
/**

Inputs:
    instructionF     : Instruction fetched from instruction memory.
    pcF              : Address of current instruction in Fetch stage.
    pc_plus_fourF    : Next sequential address (pcF + 4).

Outputs:
    instructionD     : Instruction in Decode stage.
    pcD              : PC value in Decode stage.
    pc_plus_fourD    : PC + 4 value in Decode stage.

Control Signals:

    CLR (flush_D):
        Flushes the Decode stage by inserting a NOP.
        instructionD is set to 32'h00000013 (RISC-V NOP),
        and PC-related outputs are cleared to 0.
        Used for control hazards such as taken branches
        and jumps.

    EN (stall_D):
        EN = 0 :
            Normal operation.
            Inputs are copied to outputs and the
            pipeline advances.

        EN = 1 :
            Stall condition.
            Outputs retain their previous values,
            effectively freezing the Decode stage.

Pipeline Operation Example:

    Fetch Stage:
        pcF = 100
        instructionF = ADD
        pc_plus_fourF = 104

    After F/D Register:
        pcD = 100
        instructionD = ADD
        pc_plus_fourD = 104

*************************************************/
//////////////////////////////////////////////////////////////////////////////////


module fetch_decode_register(
    instr_F,pc_F,pc_plus_four_F,instr_D,pc_D,pc_plus_four_D,clk,clr,EN
    );
    input [31:0] instr_F,pc_F,pc_plus_four_F;
    input clk,clr,EN;
    
    output reg [31:0] instr_D,pc_D,pc_plus_four_D;
    
    always @(posedge clk) begin
        if(clr) begin
        instr_D <= 32'h00000013; //this is where nop instruction is stored
        pc_D <= 32'b0;
        pc_plus_four_D <= 32'b0; // we set both pc and pc+4 to zero because by the time instr1 reaches ex stage 2 mor ir i2,i3 would be fetched so both to 
        //be flushed out hence pc for i2 and pc plus 4 for i3
        end
        else if (!EN) begin
        //normally it will run
        instr_D <= instr_F;
        pc_D <= pc_F;
        pc_plus_four_D <= pc_plus_four_F;
        
        end
        end
endmodule
