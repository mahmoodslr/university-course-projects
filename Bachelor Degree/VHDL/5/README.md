# Moore and Mealy State Machine in VHDL
**This repository contains a VHDL implementation of Moore and Mealy finite state machines (FSMs).**

## Overview
The module moore_mealy.vhd implements both a Moore and a Mealy FSM, processing an input signal x and producing output signals y (Moore) and y3 (Mealy).

## Architecture
### 1. Moore FSM (y Output)
- State Register: p_s (present state), n_s (next state).
- Transition Conditions: The FSM moves between states "00", "01", and "10", depending on the input x.
- Output Logic:
  - The output y is determined only by the current state (p_s).
  - y is 1 when p_s = "01", otherwise 0.
- Clocked Process: Updates p_s on the rising edge of clock.
### 2. Mealy FSM (y3 Output)
- State Register: p_s3 (present state), n_s3 (next state).
- Transition Conditions: Similar to the Moore FSM, but transitions depend on both x and the current state.
- Output Logic:
  - The output y3 is determined both by the current state and input x.
  - y3 is updated in a separate process based on n_s3.
- Clocked Process: Updates p_s3 on the rising edge of clock and assigns y3.
