# JK Flip-Flop Implementation in VHDL

## Overview
This repository contains two implementations of a **JK Flip-Flop** in VHDL. Both implementations describe the behavior of a JK Flip-Flop using the **Behavioral modeling style**.

## Files
- `JK.vhd`: Implements a JK Flip-Flop with an asynchronous **Set** and **Reset**.
- `JK_f.vhd`: Implements a JK Flip-Flop with additional explicit conditions for input handling.

## Description
### JK Flip-Flop (`JK.vhd`)
This module defines a **JK Flip-Flop** with the following characteristics:
- **Inputs:**
  - `J`: Input for setting the flip-flop.
  - `K`: Input for resetting the flip-flop.
  - `Reset`: Asynchronous reset input (active high).
  - `Set`: Asynchronous set input (active high).
  - `Clock`: Clock signal for triggering state changes.
- **Output:**
  - `F`: Flip-flop output.
- **Behavior:**
  - On the rising edge of `Clock`, the flip-flop state is updated based on `J` and `K`.
  - If `Reset` is high, the output is set to `0`.
  - If `Set` is high, the output is set to `1`.
  - Otherwise, the JK logic is applied:
    - `J = 0`, `K = 1` → Reset (output `0`)
    - `J = 1`, `K = 0` → Set (output `1`)
    - `J = 1`, `K = 1` → Toggle (output flips)

### JK Flip-Flop (`JK_f.vhd`)
This is an alternative implementation of a **JK Flip-Flop**, with slightly different internal handling:
- The same **inputs and outputs** are used as in `JK.vhd`.
- **Behavior:**
  - The reset and set conditions are explicitly checked **before** processing the JK logic.
  - The JK conditions are handled separately inside the clocked process.
  - The toggling behavior when `J = 1` and `K = 1` is explicitly defined.



