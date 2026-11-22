# Speaker Test Program (emu8086 - 8253)
This project demonstrates a speaker test program written in x86 Assembly, designed to run on the emu8086 emulator. It uses the Intel 8253 programmable interval timer (PIT) to generate different musical notes and play simple melodies via the PC speaker.

## Overview
The program initializes the stack, configures the 8253 timer, and waits for DIP switch input to choose between two pre-programmed melodies. It plays notes corresponding to frequencies using specific timer values and delays.

## Features
- Configures 8253 timer to generate sound.
- Plays two different tunes based on user input.
- Uses IN/OUT instructions to interface with hardware ports.
- Includes hardcoded note frequency values (DO, RE, MI, etc.).
- Displays a welcome message via interrupt `INT 21h`.

## Requirements
- emu8086 emulator 
- A system that supports running emulated DOS/8086 programs

## Song Selection
The user selects a song using DIP switch input (simulated):
- Input 0xDF (11011111b): Play first melody (`data2`)
- Input 0x7F (01111111b): Play second melody (`data3`)

## File Structure
- `start`: – Program entry point and setup
- `i8253`: – Timer configuration
- `input`: – DIP switch input handler
- `main`: – Plays the selected song
- `timer`: – Simple delay loop
- `data1`: – Note frequency table
- `data2`: – First melody data
- `data3`: – Second melody data
- `msg`: – Welcome message
