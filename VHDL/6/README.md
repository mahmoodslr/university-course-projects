# Signed Division Implementation in VHDL
**This repository contains a VHDL implementation of a signed division module, where an 8-bit signed number is divided by a 4-bit signed number.**

## Overview
The module tamrin6.vhd performs division using an external component divi, which calculates both the quotient and the remainder of the division operation.

## Architecture
### 1.Division Component (divi):
- The division operation is implemented using an external component divi.
- It takes dividend (x) and divisor (y) as inputs and produces quotient (Qou_int) and fractional (Rem_int).
- The division is clocked, meaning the result updates with the clock signal.

### 2.Signal Conversion:
- The signed inputs x and y are converted to std_logic_vector before being fed into divi.
- The outputs from divi (Qou_int and Rem_int) are converted back to signed format for output_Q and output_R.
