# Traveling Salesman Problem Solver using A* and RBFS

 ## Overview
 This project solves the Traveling Salesman Problem (TSP) using two informed search algorithms:

`A* Search` , `Recursive Best-First Search (RBFS)` It uses the Minimum Spanning Tree (MST) heuristic to estimate the cost of completing partial paths.


## 📁 Project Structure 
```
├── TSP_solver.py # Main script containing A* and RBFS implementations 
├── test1.txt # Input file containing city names and distance matrix
└── README.md # This documentation
``` 

##  Algorithms Used
###  A* Search
A graph-based search algorithm that explores paths with the lowest estimated total cost (f(n) = g(n) + h(n)), where:
- g(n): cost from start to the current node
- h(n): MST-based heuristic to estimate remaining cost
- A* Algorithm
<img src="https://github.com/user-attachments/assets/998ed812-f1d1-4ba6-ab13-ae3dbdd5d0ff" width="400" height="250" style="border: 2px solid #ccc; border-radius: 10px; box-shadow: 3px 3px 10px rgba(0,0,0,0.1);" />

### Recursive Best-First Search (RBFS)
- A memory-efficient recursive version of best-first search. Uses the same heuristic as A* but applies pathmax and limited backtracking to reduce memory usage.
- RBFS Algorithm
<img src="https://github.com/user-attachments/assets/2e549c9d-6747-455a-91ee-2ce621d6905c" width="400" height="250" style="border: 2px solid #ccc; border-radius: 10px; box-shadow: 3px 3px 10px rgba(0,0,0,0.1);" />

### Heuristic Function (MST-based)
For unvisited cities, the heuristic is calculated as:
- Cost of the Minimum Spanning Tree (MST) over unvisited cities
- Cost from the current city to the nearest unvisited
- Cost from one of the unvisited cities back to the start
- This heuristic is:
  - Admissible (never overestimates)
  - Efficient for small/medium TSP instances
