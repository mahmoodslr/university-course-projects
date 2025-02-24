# Project
## Overview
**This project consists of a simple processor with integrated memory and a set of basic operations (register, I/O, and memory instructions). It is designed using VHDL, simulating a basic computing architecture that incorporates the following components:**
  - **Block RAM: A memory block for storing data with read/write capabilities.**
  - **Processor Unit: Handles operations based on an instruction register, with support for interrupts, memory, and I/O operations.**
    
**The architecture simulates the behavior of a basic processor executing different instructions like load, add, branch, and halt, with an emphasis on handling interrupts and memory interactions.**

## Components
### 1. Block RAM
The `Block_Ram` entity is a memory module that supports:
- Read: Fetch data from memory using the address provided.
- Write: Store data into memory at a specific address if write is enabled.
#### Ports:
- `ReadAddres`: Address to read data from.
- `WriteAddres`: Address to write data to.
- `DataIn`: Data input to be written into memory.
- `DataOut`: Data output fetched from memory.
- `clock`: Clock signal for synchronization.
- `WriteEnable`: Signal to enable writing data.

### 2. Processor Unit
The project entity simulates a simple processor that can handle the following operations:
- Registers: Store temporary data, including the accumulator (`AC`), instruction register (`IR`), output register (`OUTR`), etc.
- Interrupts: Supports interrupt handling, saving/restoring data to/from the stack pointer (`SP`).
- Memory Operations: Executes load and store operations to/from memory.
- I/O Operations: Reads and writes to/from the output register (`OUTR`).
#### Ports:
- `int`: Interrupt signal.
- `data`: Data input for processing.
- `start`: Start signal to initiate operations.
- `clock`: Clock signal for synchronization.
- `R`, `DR`, `AC`, `IR`, `OUTR`, `AR`, `PC`, `SP`, `IEN`, `S`, `E`, `SC`: Various status and data signals representing the processor's registers and states.

## Architecture Details
### Block RAM
The `Block_Ram` entity has a memory block represented by a type `RAMtype`, which is an array of unsigned values. This block is configured as a "Block" memory style using the `ram_style` attribute. The architecture is designed to handle 16-bit data and a 7-bit address space.

### Processor Operations
The processor has several states, controlled by the `SC_signal`. It supports multiple instructions:
- Register Operations: CLA, CLE, CMA, CME, etc.
- I/O Operations: OUT, ION.
- Memory Operations: LDA, ADD, BUN, RET.
- 
Instruction Execution
Instructions are fetched from memory and executed with the following steps:
1.  Fetch: Load instruction from memory.
2.  Decode: Determine the instruction type (register, I/O, memory).
3.  Execute: Perform the corresponding action, updating the processor's registers and memory.
4.  Interrupt Handling: If an interrupt occurs, the processor saves its state and processes the interrupt.

## How to Run
- Ensure you have a VHDL simulator (e.g., ModelSim, Vivado, etc.).
- Load the VHDL files into your simulator.
- Simulate the project, ensuring the clock and input signals are properly set.
- Observe the processor's operation through the output signals (DR, AC, IR, etc.).
