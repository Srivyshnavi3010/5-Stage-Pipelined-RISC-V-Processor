`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2026 19:50:16
// Design Name: 
// Module Name: top_module
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



//module top(clk, rst);
module top_module (clk, rst, alu_bit0);

    // input port
    input clk;                                                          // Clock signal
    input rst;                                                          // reset signal

    // output port
//   output [31:0] alu_result;                                           // ALU result
   output alu_bit0;

    wire [31:0] alu_result;    
    assign alu_bit0 = alu_result[0];
    // wire declaration
    wire [31:0] instruction;                                            // Instruction read from the instruction memory
    wire [31:0] read_data_1, read_data_2;                               // Data read from the register file
    wire [31:0] read_data_1_D, read_data_2_D;                           // Data read from the register file
    wire [31:0] read_data_1_E, read_data_2_E;                           // Data read from the register file
    wire [31:0] read_data;                                              // Data read from the data memory
    wire [31:0] write_data;                                             // Data to be written to the data memory
    wire [31:0] in;                                                     // input address from the program counter
    wire [31:0] out;                                                    // Output address from the program counter
    wire [31:0] extended_imm;                                           // Extended immediate value
    wire [31:0] operand_1;                                              // ALU operand 1
    wire [31:0] operand_2;                                              // ALU operand 2
    wire [31:0] operand_1_reg;                                          // Forwarded operand 1
    wire [31:0] operand_2_reg;                                          // Forwarded operand 2
    wire [31:0] result_M;                                               // ALU result in memory stage
    wire [31:0] write_data_M;                                           // Data to be written to memory in memory stage
    wire [31:0] read_data_W;                                            // Data read from memory in writeback stage
    wire [31:0] result_W;                                               // ALU result in writeback stage
    wire [31:0] pcD, pcE;                                               // Program counter values in decode and execute stages
    wire [31:0] pc_plus_four_D, pc_plus_four_E, pc_plus_four_M, pc_plus_four_W; // PC + 4 values in different stages
    wire [31:0] extended_imm_E, extended_imm_M, extended_imm_W;         // Extended immediate values in different stages
    wire [31:0] branch_jump_address;                                    // Branch or jump address
    wire [31:0] correct_address;                                        // Correct address for PC
    wire [31:0] instructionD;                                           // Instruction in decode stage
    wire [31:0] intsruction_address;                                    // Instruction address
    wire [4:0] alu_control;                                             // ALU control signal
    wire [4:0] alu_control_D, alu_control_E;                            // ALU control signal
    wire [4:0] read_address_1_E, read_address_2_E, write_address_E;     // Register addresses in execute stage
    wire [4:0] write_address_M, write_address_W;                        // Register addresses in memory and writeback stages
    wire [2:0] jump_branch;                                             // Jump or branch signal
    wire [2:0] jump_branch_D, jump_branch_E;                            // Jump or branch signal
    wire [2:0] imm_src;                                                 // Immediate source
    wire [1:0] result_src, alu_src, alu_src_E, alu_src_D;               // Result source and ALU source
    wire [1:0] result_src_E, result_src_M, result_src_W;                // Result source in different stages
    wire [1:0] data_size, data_size_E, data_size_M;                     // Data size in different stages
    wire [1:0] forward_1_E, forward_2_E;                                      // Forwarding control signals
    wire pc_src, mem_write, reg_write;                                  // Control signals for program counter, data memory, and register file
    wire mem_write_E, mem_write_M;                                      // Memory write control signals in different stages
    wire reg_write_E, reg_write_M, reg_write_W;                         // Register write control signals in different stages
    wire extension_type;                                                // Extension type
    wire extension_type_E, extension_type_M;                            // Extension type in different stages
    wire zero, neg, less_than;                                          // Zero, negative, and less than flags
    wire flush_D, flush_E;                                              // Clear and flush signals
    wire stall_F, stall_D;                                              // Stall signals
    wire pc_correct_src, pc_src_predection, pc_src_predection_E;        // PC source control signals

// module instantiation

    // fetch_decode_register
    fetch_decode_register fetch_decode_register_inst (.instr_F(instruction), .pc_F(intsruction_address), .pc_plus_four_F(out + 4), .instr_D(instructionD), .pc_D(pcD),
    .pc_plus_four_D(pc_plus_four_D), .clk(clk), .clr(flush_D), .EN(stall_D));

    // decode_execute_register
    decode_execute_register decode_execute_register_inst (.read_data_1_D(read_data_1), .read_data_2_D(read_data_2), .pcD(pcD), .read_address_1_D(instructionD[19:15]),
    .read_address_2_D(instructionD[24:20]), .write_address_D(instructionD[11:7]), .extended_imm_D(extended_imm), .pc_plus_four_D(pc_plus_four_D), .jump_branch_D(jump_branch),
    .result_src_D(result_src), .mem_write_D(mem_write), .alu_control_D(alu_control), .alu_src_D(alu_src), .reg_write_D(reg_write), .data_size_D(data_size),
    .extension_type_D(extension_type), .pc_src_predection_D(pc_src_predection), .read_data_1_E(read_data_1_E), .read_data_2_E(read_data_2_E), .pcE(pcE), .read_address_1_E(read_address_1_E), .read_address_2_E(read_address_2_E),
    .write_address_E(write_address_E), .extended_imm_E(extended_imm_E), .pc_plus_four_E(pc_plus_four_E), .jump_branch_E(jump_branch_E), .result_src_E(result_src_E), .mem_write_E(mem_write_E),
    .alu_control_E(alu_control_E), .alu_src_E(alu_src_E), .reg_write_E(reg_write_E), .data_size_E(data_size_E), .extension_type_E(extension_type_E), .pc_src_predection_E(pc_src_predection_E), .clk(clk), .CLR(flush_E), .EN(stall_D));


    // mux to select the next forwardA register value
    mux_3 mux3_forwardA_register_inst(.operand_1(read_data_1_E), .operand_2(write_data), .operand_3(result_M), .result(operand_1_reg), .select(forward_1_E));

    // mux to select the next forwardB register value
    mux_3 mux3_forwardB_register_inst(.operand_1(read_data_2_E), .operand_2(write_data), .operand_3(result_M), .result(operand_2_reg), .select(forward_2_E));

    // execute_memory_register
    execute_memory_register execute_memory_register_inst (.result_E(alu_result), .write_data_E(operand_2_reg), .write_address_E(write_address_E), .pc_plus_four_E(pc_plus_four_E), 
    .result_src_E(result_src_E), .mem_write_E(mem_write_E), .reg_write_E(reg_write_E), .extended_imm_E(extended_imm_E), .data_size_E(data_size_E), .extension_type_E(extension_type_E),
    .result_M(result_M), .write_data_M(write_data_M), .write_address_M(write_address_M), .pc_plus_four_M(pc_plus_four_M), .result_src_M(result_src_M),
    .mem_write_M(mem_write_M), .reg_write_M(reg_write_M), .extended_imm_M(extended_imm_M), .data_size_M(data_size_M), .extension_type_M(extension_type_M), .clk(clk));   

    //memory_writeback_register
    memory_writeback_register memory_writeback_register_inst (.result_M(result_M), .write_address_M(write_address_M), .pc_plus_four_M(pc_plus_four_M), .read_data_M(read_data), 
    .result_src_M(result_src_M), .reg_write_M(reg_write_M), .extended_imm_M(extended_imm_M) , .result_W(result_W), .write_address_W(write_address_W), .pc_plus_four_W(pc_plus_four_W), .read_data_W(read_data_W), 
    .result_src_W(result_src_W), .reg_write_W(reg_write_W), .extended_imm_W(extended_imm_W), .clk(clk));

    //address_calculation
    address_calculation address_calculation_inst (.pc(pcD), .imm_extend(extended_imm), .branch_jump_address(branch_jump_address));

    // Hazard Control Unit
    hazard hazard_control_unit_inst(.read_address_1_D(instructionD[19:15]), .read_address_2_D(instructionD[24:20]), .jump_branch_D(jump_branch), .read_address_1_E(read_address_1_E),
    .read_address_2_E(read_address_2_E), .write_address_E(write_address_E), .pc_src_E(pc_src), .result_src_E(result_src_E), .jump_branch_E(jump_branch_E), .pc_src_predection_E(pc_src_predection_E),
    .fall_through_address(pcE + 4),.branch_addresss(branch_jump_address), .write_address_M(write_address_M), .reg_write_M(reg_write_M), .write_address_W(write_address_W), .reg_write_W(reg_write_W),
    .stall_F(stall_F), .stall_D(stall_D), .flush_D(flush_D), .flush_E(flush_E), .forward_1_E(forward_1_E), .forward_2_E(forward_2_E), .pc_correct_src(pc_correct_src), .correct_address(correct_address), 
    .pc_src_predection(pc_src_predection), .rst(rst), .clk(clk));

    // Mux to select the next PC value
    mux_2 mux2_pc_value_inst(.operand_1(intsruction_address + 4), .operand_2(correct_address), .result(in), .select(pc_correct_src));

    // Program Counter
    pc pc_inst(.clk(clk), .reset(rst), .in(in), .out(out), .EN(stall_F));

    //Mux to select the next branch address
    wire pc_sel_final;
    assign pc_sel_final = flush_D?pc_src:pc_src_predection;
    mux_2 mux2_branch_address_inst(.operand_1(out), .operand_2(branch_jump_address), .result(intsruction_address), .select(pc_sel_final));

    // Instruction Memory
    //imem imem_inst(.addr({2'b00,intsruction_address[31:2]}), .instruction(instruction));

/**wire [31:0] instr_out;
parameter BASE_ADDRESS = 32'h00000000;
wire [10:0] bram_addr;
wire [31:0] addr;
assign addr = out[31:0];
assign bram_addr = (addr - BASE_ADDRESS) >> 2;
 blk_mem_gen_0 blk_mem_gen_0_inst (
  .clka(clk),
  .ena(1'b1),
  .wea(1'b0),
  .addra(bram_addr),
  .dina(32'b0),
  .douta(instr_out)
);
    assign instruction = instr_out;**/
    
    instruction_memory imem_inst( .address(out), .instruction(instruction));
    // Mux to select the register input value
    mux_4 mux4_register_input_inst(.operand_1(result_W), .operand_2(read_data_W), .operand_3(pc_plus_four_W), .operand_4(extended_imm_W), .result(write_data), .select(result_src_W));

    // Register File
    reg_file reg_file_inst(.read_addr1(instructionD[19:15]), .read_addr2(instructionD[24:20]), .write_addr(write_address_W), .write_data(write_data), .clk(clk),
    .write_en(reg_write_W), .read_data1(read_data_1), .read_data2(read_data_2), .reset(rst));

    // Mux to select the first operand for the ALU
    mux_2 mux2_ADDER_OPERAND_1_inst(.operand_1(operand_1_reg), .operand_2(pcE), .result(operand_1), .select(alu_src_E[1]));

    // Mux to select the second operand for the ALU
    mux_2 mux2_ADDER_OPERAND_2_inst(.operand_1(operand_2_reg), .operand_2(extended_imm_E), .result(operand_2), .select(alu_src_E[0]));

    // ALU
    ALU alu_inst(.operand_1(operand_1), .operand_2(operand_2), .zero(zero), .neg(neg), .less_than(less_than), .result(alu_result), .ALU_control(alu_control_E));
   




    // Data Memory
//    data_memory data_memory_inst(.address({2'b00,result_M[31:2]}), .write_data(write_data_M), .read_data(read_data), .clk(clk), .rst(rst), 
//    .data_size(data_size_M), .extension_type(extension_type_M), .write_enable(mem_write_M));
data_memory data_memory_inst(
    .address({2'b00,result_M[31:2]}),
    .write_data(write_data_M),
    .read_data(uart_bus_data),
    .clk(clk),
    .rst(rst),
    .data_size(data_size_M),
    .extension_type(extension_type_M),
    .write_enable(mem_write_M)
     // connect to internal uart FSM
);


    // Immediate Value Extender
    imm_extend imm_extend_inst(.imm(instructionD[31:7]), .extended_imm(extended_imm), .imm_src(imm_src));

    // Control Unit
    control_unit control_unit_inst(.opcode(instructionD[6:0]), .funct3(instructionD[14:12]), .funct7(instructionD[31:25]), .jump_branch(jump_branch), .result_src(result_src), .mem_write(mem_write), .alu_control(alu_control), .alu_src(alu_src),
    .imm_src(imm_src), .reg_write(reg_write), .data_size(data_size), .extension_type(extension_type));

    // Jump and Branch Decision Unit
    jump_branch_decision jump_branch_decision_inst(.operand_1(read_data_1_E), .operand_2(read_data_2_E), .zero(zero), .neg(neg), .less_than(less_than), .jump_branch(jump_branch_E), .pc_src(pc_src));
    

endmodule



