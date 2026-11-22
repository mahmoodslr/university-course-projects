# LED Control via Serial Port - Assembly Program

## Overview
This program is written in x86 Assembly and is designed to control LEDs based on the input received from the serial port (COM1). It continuously checks the input status and lights up specific LEDs based on predefined bit patterns.

## How It Works
- The program reads from the serial port status register at address 0x3FD0.
- It compares the input byte (AL) with specific bit patterns:
  - 11111101b → Turn on LED pattern 1 (BH = 11111111b)
  - 11110111b → Turn on LED pattern 2 (BH = 00000101b)
  - 11011111b → Turn on LED pattern 3 (BH = 11110000b)
-If none of the specified patterns match, it proceeds to the flashing routine without changing BH.

## Flashing Routine
- The value in BH is sent to port 0x3FD2 to control the LEDs.
- A delay is created using two LOOP instructions with CX = 0x1FFF to make the LED pattern visible.
- After the delay, all LEDs are turned off by sending 00000000b to the same port.
- Another delay follows before the program returns to the main loop.

## Registers Used
- `AL`: Holds the byte read from the serial port.
- `BH`: Holds the LED pattern to be displayed.
- `DX`: Used for specifying port addresses.
- `CX`: Used for delay loops.
  
## Ports
- `0x3FD0`: Read port (input status).
- `0x3FD2`: Write port (LED control output).
