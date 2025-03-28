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

---
# T3

## Overview
This assembly program simulates a three-phase traffic light system with a countdown timer using a simulated LED display. The traffic light operates with specific timing for each phase, and a countdown timer is displayed on an LED screen to indicate the remaining time for each state.

## Features

- Three-phase traffic light system
  - Green light for the right street (17 seconds)
  - Green light for the left street (10 seconds)
  - Green lights for vertical streets (13 seconds)
  - Yellow light for transition phases (3 seconds each)
- Countdown Timer on LED Display
  - A decrementing counter is displayed on the LED screen for each phase.

## Implementation Details

- The program starts with all traffic lights set to red.
- It iterates through a predefined sequence of traffic light states stored in memory.
- Each state has a specific duration, which is handled using a countdown loop.
- The countdown timer is output to port 199.
- The system uses INT 15h for time delays.

## Code Structure

1- Traffic Light State Selection
- The program reads the current traffic light state from memory (situation table).
- It compares the state using CMP and jumps to the corresponding routine.

2- Countdown Timer Execution
- Each traffic light phase has a countdown timer that decrements the displayed value on the LED display (port 199).
- A delay loop ensures that each second is properly simulated.

3- Looping Through Traffic Light States
- After executing a state, the program moves to the next state in the sequence.
- If the last state is reached, the sequence restarts from the beginning.
