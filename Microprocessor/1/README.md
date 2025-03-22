# Description
This assembly program converts a decimal number (14090) into its ASCII representation and prints it on the screen using 8086 assembly language.

## How It Works
1-Initialization:
- The number 14090 is loaded into AX.
- CX is set to 0, which will later count the number of digits.
  
2-Extracting Digits (LOOP1):
- The number is repeatedly divided by 10, extracting digits one by one.
- The remainder (DX) contains the last digit, which is pushed onto the stack.
- CX is incremented to track the number of digits.
- The loop continues until AX becomes zero.
  
3-Printing Digits (LOOP2):
- The stored digits are popped from the stack (LIFO order) to restore the correct sequence.
- 30H is added to convert the numeric value to its ASCII character.
- The character is printed using DOS interrupt 21H (function 02H).
- The loop repeats until all digits are printed.

## Output
### The program prints:
**`14090`**

## Notes

- This code works in emu8086 or DOSBox with NASM/MASM/TASM.
- It assumes 16-bit real mode execution.
