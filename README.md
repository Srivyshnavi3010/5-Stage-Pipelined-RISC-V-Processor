# 5-Stage-Pipelined-RISC-V-Processor (RV321)



A complete 32-bit pipelined RISC-V (RV32I) processor implemented in Verilog HDL, featuring hazard detection, data forwarding, branch handling, pipeline registers, instruction and data memory subsystems, and FPGA implementation using Xilinx Vivado.

## Overview

Modern processors achieve high performance through pipelining, where multiple instructions are executed simultaneously at different stages of execution. This project implements a complete 32-bit 5-stage pipelined RISC-V processor supporting the RV32I instruction set architecture.

The processor incorporates forwarding paths, hazard detection mechanisms, branch handling logic, pipeline registers, and memory interfaces to achieve correct and efficient instruction execution. The design was functionally verified and successfully synthesized, implemented, and timing-verified using Xilinx Vivado.

---

## Processor Architecture

The processor follows the classical 5-stage pipeline architecture:

```text
Instruction Fetch (IF)
↓
Instruction Decode (ID)
↓
Execute (EX)
↓
Memory Access (MEM)
↓
Write Back (WB)
```

Pipeline registers are inserted between stages to allow multiple instructions to execute concurrently, significantly improving throughput compared to a single-cycle processor.



## Pipeline Stages

### Instruction Fetch (IF)

Responsible for fetching instructions from instruction memory.

Key Components:

- Program Counter (PC)
- Instruction Memory
- Branch/Jump Selection Logic

Functions:

- Fetches instructions from memory
- Updates Program Counter
- Handles branch and jump redirection

---

### Instruction Decode (ID)

Responsible for decoding instructions and generating control signals.

Functions:

- Instruction decoding
- Register file access
- Immediate value generation
- Control signal generation

Key Components:

- Control Unit
- Register File
- Immediate Generator

---

### Execute (EX)

Responsible for performing arithmetic, logical, comparison, and address generation operations.

Supported ALU Operations:

- ADD
- SUB
- AND
- OR
- XOR
- SLL
- SRL
- SRA
- SLT
- SLTU

Additional Functions:

- Branch evaluation
- Effective address calculation
- Data forwarding

---

### Memory Access (MEM)

Responsible for load and store operations.

Supported Memory Instructions:

#### Load Instructions

- LB
- LH
- LW
- LBU
- LHU

#### Store Instructions

- SB
- SH
- SW

Functions:

- Data memory access
- Load data processing
- Store data handling

---

### Write Back (WB)

Responsible for updating the architectural state of the processor.

Write-back Sources:

- ALU Result
- Memory Output
- PC-related values

Functions:

- Register file update
- Instruction completion

---

## Pipeline Registers

Dedicated registers are used between stages to preserve intermediate values.

### IF/ID Register

Stores:

- Current PC
- Fetched Instruction

### ID/EX Register

Stores:

- Source Operands
- Immediate Values
- Control Signals
- Register Addresses

### EX/MEM Register

Stores:

- ALU Results
- Store Data
- Branch Information
- Memory Control Signals

### MEM/WB Register

Stores:

- Memory Data
- ALU Output
- Write-Back Control Signals

---

## Hazard Handling

### Data Hazards

Data hazards occur when an instruction depends on the result of a previous instruction.

Example:

```assembly
ADD x5, x1, x2
SUB x6, x5, x3
```

Resolution:

- Forwarding Unit
- EX/MEM → EX Forwarding
- MEM/WB → EX Forwarding

This minimizes pipeline stalls and improves performance.

---

### Load-Use Hazards

Example:

```assembly
LW x5, 0(x1)
ADD x6, x5, x2
```

Since forwarding alone cannot resolve this dependency immediately, a Hazard Detection Unit inserts a pipeline stall.

Functions:

- Dependency Detection
- Stall Generation
- Pipeline Control

---

### Control Hazards

Control hazards occur due to branch and jump instructions.

Example:

```assembly
BEQ x1, x2, LABEL
```

Resolution:

- Branch Decision Logic
- Pipeline Flush Logic
- Program Counter Redirection

---

## Major Modules Implemented

- Program Counter (PC)
- Instruction Memory
- Data Memory
- Control Unit
- Register File
- Immediate Generator
- Arithmetic Logic Unit (ALU)
- Hazard Detection Unit
- Forwarding Unit
- Branch Decision Unit
- Address Calculation Unit
- IF/ID Pipeline Register
- ID/EX Pipeline Register
- EX/MEM Pipeline Register
- MEM/WB Pipeline Register
- Multiplexer Network

---

## Verification

The processor was functionally verified through simulation and waveform analysis.

Verification included:

- Instruction Fetch Validation
- Register File Verification
- Immediate Generation Verification
- ALU Operation Verification
- Branch Handling Verification
- Memory Access Verification
- Hazard Detection Verification
- Forwarding Verification
- Pipeline Register Verification
- End-to-End Instruction Execution

---

## FPGA Implementation Flow

The complete FPGA flow was carried out using Xilinx Vivado.

```text
RTL Design
↓
Elaboration
↓
Synthesis
↓
Implementation
↓
Timing Analysis
```

Results:

- RTL Elaboration Successful
- Synthesis Successful
- Implementation Successful
- Timing Verified
- Timing Constraints Met
- Resource Utilization Verified

---

## Tools and Technologies

- Verilog HDL
- RISC-V RV32I ISA
- Xilinx Vivado
- FPGA Design Flow
- Digital Hardware Design

---

## Learning Outcomes

This project provided practical experience in:

- Processor Architecture
- RISC-V ISA
- Pipeline Design
- Hazard Detection
- Data Forwarding
- RTL Design
- FPGA Synthesis
- Timing Analysis
- Digital Hardware Verification

---

## Future Improvements

- Branch Prediction Unit
- Cache Memory Integration
- UART Interface
- Additional RISC-V Extensions
- FPGA Board Deployment
- Performance Optimization

---

## Author

**Poralla Sri Vyshnavi**

Dual Degree (B.Tech + M.Tech) 
Electronics and Electrical Communication Engineering
Indian Institute of Technology Kharagpur
