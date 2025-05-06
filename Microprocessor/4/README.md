# 7-Segment Display Controller 

## Overview
This assembly program is written for the x86 architecture and is designed to run in the emu8086 emulator. 
It controls a 7-segment display using output to a specific port and responds to inputs received from the serial port. 
Based on different input values, the display operates in one of three different modes.

## Program Components
- `fnd equ 3FF0h`
Output port address for the 7-segment display.

- `data section`
A predefined list of binary patterns representing hexadecimal digits (0–F) for display on a 7-segment module.

- `Input from COM port (3FD0h)`
The program continuously checks the serial input and branches to one of the display modes based on the value received.

## Display Modes
- cycle1: Reverse display from F to 0
  - Trigger value: 01111111b
  - Displays digits from data[15] down to data[0].

- cycle2: Forward display of even indices (1, 3, ..., 15)
  - Trigger value: 11111101b
  - Skips alternate bytes, starting from data[1] and moving forward.

- cycle3: Reverse display of even indices (14, 12, ..., 0)
  - Trigger value: 11111011b
  - Skips alternate bytes, starting from data[14] and moving backward.
 
## Technical Details
- A delay loop using the cx register (mov cx, 9990h / loop $) creates visible pauses between each display output.
- out dx, al sends the content of register al to the port defined in dx.
- Each display cycle ends by jumping back to the input-checking routine to wait for the next command.
