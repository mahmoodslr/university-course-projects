# Traffic Light & 30 Seconds Timer

## 1. 3-Stroke Traffic Light

### Description

This assembly program simulates a three-phase traffic light system using the 8086 microprocessor and the Traffic_Lights.exe emulator in emu8086. The program controls the traffic light sequence with three states, ensuring that only one direction has a green light at a time, while the others remain red. Before switching to the next direction, the current green light turns yellow as a transition phase.

### Functionality
- One green light at a time while others remain red.
- Yellow transition phase before switching to the next direction.
- Uses timing delay to maintain each light phase for 5 seconds.
- The loop continues indefinitely to maintain the traffic light cycle.

## 2. 30 Seconds Timer

### Description

This assembly program simulates a 30-second countdown timer using the 8086 microprocessor and the led_display.exe emulator in emu8086. The countdown starts from 30 and decreases by 1 every second.

### Functionality
- Displays countdown from 30 to 0 on the LED display.
- Uses INT 15h (AH=86h) to introduce a 1-second delay per count.
- Stops execution when the countdown reaches 0.
