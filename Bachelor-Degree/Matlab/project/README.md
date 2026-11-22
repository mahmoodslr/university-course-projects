# 🚦 Traffic Light Car Simulation (MATLAB)

A MATLAB simulation of a car moving through a sequence of traffic lights.  
The car travels between intersections, obeys traffic signals, stops at red lights, waits until the signal turns green, and then continues its journey.

---

## 📌 Features

- Simulates a car moving through multiple traffic lights.
- Reads traffic light positions from an Excel file.
- Reads green and red light durations from an Excel file.
- Calculates the distance between intersections.
- Simulates traffic light state (Green/Red) in real time.
- Stops the vehicle at red lights.
- Displays the remaining waiting time at each red light.
- Real-time animation using MATLAB plotting.

---

## 📂 Project Structure

```
Project/
│
├── Project.xlsx          % Input data
├── main.m                % Main simulation script
├── distancecalc.m        % Distance calculation function
├── lightstate.m          % Traffic light state function
└── README.md
```

---

## 📊 Excel File Structure

The project uses an Excel file named:

```
Project.xlsx
```

It contains two worksheets.

### TrafficLight

| X | Y | Name |
|---|---|------|
| ... | ... | ... |

Contains:

- Traffic light coordinates
- Traffic light names

---

### Time

| Green Duration | Red Duration |
|---------------|--------------|
| ... | ... |

Contains:

- Green light duration (seconds)
- Red light duration (seconds)

Each row corresponds to the traffic light in the same row of the **TrafficLight** sheet.

---

## ⚙️ Functions

### distancecalc()

Computes the Euclidean distance between two traffic lights.

```matlab
d = sqrt((x2-x1)^2 + (y2-y1)^2);
```

---

### lightstate()

Determines whether a traffic light is green or red.

Returns

- `1` → Green
- `0` → Red

based on the current simulation time.

---

## 🚗 Simulation Process

1. Load traffic light positions.
2. Load signal timings.
3. Place the car at the first traffic light.
4. Move toward the next traffic light.
5. When reaching an intersection:
   - If the light is **green**, continue.
   - If the light is **red**, stop and wait.
6. Repeat until the final traffic light is reached.

