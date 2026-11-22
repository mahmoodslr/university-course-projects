# BCD Adder and 4-Bit Full Adder
## Overview
This project implements a Binary-Coded Decimal (BCD) Adder using a 4-bit Full Adder as a submodule. The BCD Adder ensures that the sum of two 4-bit inputs is correctly adjusted if it exceeds the valid BCD range (0–9).

## Components
### 1. BCD Adder (BCD_Adder.vhd)
* Adds two 4-bit signed inputs (X and Y) along with a carry input (CIN).
* Uses an instance of Full_Adder_4 to perform the initial 4-bit addition.
* Checks if the sum exceeds the valid BCD range and applies a correction factor (0110).
* Uses another Full_Adder_4 instance to adjust the sum if necessary.
* Outputs: (S: Adjusted 4-bit sum - COUT: Carry-out signal)
### 2. 4-Bit Full Adder (Full_Adder_4.vhd)
* Performs addition of two 4-bit signed numbers along with a carry input.
* Computes: (S: 4-bit sum result - COUT: Carry-out based on overflow conditions)
