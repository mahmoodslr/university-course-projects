# 💡 Light Sensor Alarm System in Assembly (emu8086)


## 📌 Description

This project is an assembly program written for emu8086, simulating a simple light sensor system with an LED alarm mechanism. The program has been designed and modified to meet the following two conditions based on the class assignment:
  
1- If the light level drops below a threshold value (0x67), the system triggers a blinking LED alarm (LEDs 4–8). The alarm continues until the light level returns to normal.
  
2- If the user presses keys 0 and 1 simultaneously (simulated through a specific bit pattern on the input port), the program stops execution.


## 🛠 How It Works
### 🔄 Main Loop
- Keyboard Check: The CheckKeys routine is called to verify if the user has pressed the 0 and 1 keys simultaneously (which sends 0xFC from port 3FD0H). If so, the program halts.
#### Sensor Reading:
- Sends a dummy value to port `3FCAH`.
- Waits briefly using a busy loop.
- Reads the light sensor value from the same port into register `BL`.
#### Display and Feedback:
- A character is displayed using `int 10H`.
- A short message (back, containing backspaces) is printed with `int 21H`.
#### Threshold Check:
- If the light sensor reading (`BL`) is greater than `0x67`, the system continues polling.
- If the light level is less than or equal to `0x67`, the program jumps to the FlashLeds routine.

### 🚨 Flashing LED Alarm (FlashLeds)
- Sends `11110000B` (LEDs 4 to 7 ON) to port `3FD2H`.
- Waits using a long delay loop.
- Sends `00000000B` (LEDs OFF).
- Rechecks the keyboard for the stop condition.
- Returns to the main loop, repeating the flashing sequence until the light level becomes normal.


### ⌨️ Keyboard Check (CheckKeys)
- Reads from port `3FD0H` and checks for the bit pattern `11111100B`, indicating that both keys `0` and `1` are pressed.
- If detected, halts the system using `hlt`.


## I/O Port 
| Port    | Purpose                   |
| ------- | ------------------------- |
| `3FCAH` | Light sensor input/output |
| `3FD0H` | Keyboard input check      |
| `3FD2H` | LED output control (4–8)  |


## 💾 Data Section
` back db 8,8,8,8,'$' `

This defines a short message of backspaces used by DOS interrupt int 21H (AH = 9) to simulate a clear or erase effect.
