# VHDL 2-to-1 Multiplexer with AND and OR Gates

### Overview
This project implements a 2-to-1 multiplexer (MUX) using behavioral VHDL. The design includes two basic logic gates: AND and OR. The multiplexer selects one of two input signals based on a control signal and outputs the selected value.

### Key Components
* AND_2: A 2-input AND gate.
* OR_2: A 2-input OR gate.
* MUX_2TO1: A 2-to-1 multiplexer that uses the AND and OR gates for its functionality.

### Description
#### Entities:
**AND_2:**
* Inputs: A_2, B_2 (2-bit input)
* Output: F_2 (Single-bit output)
* This component performs a logical AND operation on two input signals.

**OR_2:**

* Inputs: A_1, B_1 (2-bit input)
* Output: F_1 (Single-bit output)
* This component performs a logical OR operation on two input signals.

**MUX_2TO1:**

* Inputs: I (2-bit input vector), S (1-bit selector input)
* Output: F (1-bit output)
* This component implements a 2-to-1 multiplexer. It selects one of the inputs based on the control signal S:
  When S = 0, the output is I(0).
  When S = 1, the output is I(1).

### Functional Description:
The multiplexer uses two AND gates (AND_2) to conditionally pass the inputs based on the selector signal S. The output of the AND gates is then fed into an OR gate (OR_2), which produces the final output.

* AND0: Performs an AND operation on the first input (I(0)) and the inverse of the selector signal (not(S)), and stores the result in E(0).
* AND1: Performs an AND operation on the second input (I(1)) and the selector signal (S), and stores the result in E(1).
* OR0: Performs an OR operation on E(0) and E(1) to produce the final output F.
