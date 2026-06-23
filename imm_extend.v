`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.06.2026 19:41:11
// Design Name: 
// Module Name: imm_extend
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
/** The imm extend module generates the correct 32-bit immediate value for different risk-v instruction formats
The immediate field is extracted from the instruction and extended to 32 bit before being used by the data path
different instruction formats store immediate bits in different locations
I-Type addi,j=lw,jalr
S-Type sw
B-Type beq,bne,blt,bge
U-Type lui,aipc
J-Type jal

The conteol unot imm_src specifies which instruction is being used. Based on that the module reconstructs
the immediate field and performs the required sign oe zero extension

The generated 32 bit immediate instruction is used bu the ALU for arithmetic operations, addr calculations, branch target generation 
and jump instructions **/
//////////////////////////////////////////////////////////////////////////////////


module imm_extend(
    imm,extended_imm,imm_src
    );
    
    input [31:7] imm;
    input [2:0] imm_src;
    
    parameter size = 32;
    
    output reg [size-1:0] extended_imm;
    
    always @(*) begin
        case(imm_src)
        //u format
        0 : begin
            extended_imm = {imm[31:12],12'b0};
            end
        //j format
        1 : begin
            extended_imm = {{12{imm[31]}},imm[19:12],imm[20],imm[30:21],1'b0};
            end
        //s format
        2 : begin
            extended_imm = {{20{imm[31]}}, imm[31:25], imm[11:8], 1'b0};
            end
        //b format
        3 : begin
            extended_imm = {{20{imm[31]}}, imm[7], imm[30:25], imm[11:8], 1'b0};
            end
        //i signed and jalr 
        4 : begin
            extended_imm = {{20{imm[31]}}, imm[31:20]};
            end
        //i shift   
        5 : begin
            extended_imm = {{27{imm[31]}}, imm[24:20]};
            end
        //i unsigned
        6 : begin
            extended_imm = {20'b0, imm[31:20]};
            end
        default: extended_imm = 32'hxxxxxxxx;
     endcase
     end
endmodule
