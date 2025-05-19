# 🧬 Fire Station Location Optimization using Genetic Algorithm
This Python project uses a Genetic Algorithm to determine the best location for placing a fire station in a city grid, where different areas have varying risk levels. It models the city with a map including a river (with limited bridge crossings) and evaluates potential locations to minimize the total weighted distance to high-risk areas.

## Overview
- The city is represented as an 11x10 grid.
- Each cell contains a risk level from 0 to 10.
- A river divides the map in the middle, and crossing is only allowed through bridges.
- The goal is to minimize response time by placing the fire station at a position that results in the lowest total risk-weighted distance to all other accessible locations.

## Algorithm
Genetic Algorithm:
- Population size: 50
- Generations: 100
- Mutation rate: 10%
- Each individual is a coordinate (x, y) on the map.
- Fitness is calculated as the sum of the Manhattan distance to all high-risk cells, adjusted for river constraints.

The algorithm uses:
- Random initial population generation
- Parent selection (random)
- Crossover (mixing coordinates)
- Mutation (random relocation)

## Features
- Models a realistic city grid with impassable river sections and bridge crossings.
- Calculates a fitness matrix showing risk-weighted distance scores.
- Visualizes the best fire station placement on the map using an emoji 🚒.
