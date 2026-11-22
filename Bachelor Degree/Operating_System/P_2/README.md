# Memory Management Systems and Page Replacement Algorithms
This repository contains implementations of memory management techniques and page replacement algorithms for simulating memory allocation and process scheduling. The programs include:

* Buddy System Memory Allocation
* Memory Allocation Strategies (First Fit, Best Fit, Worst Fit, Next Fit)
* Page Replacement Algorithms (FIFO, LRU, Optimal, Clock)

---

##  1-Buddy System Memory Allocation
The Buddy System is an algorithm used for dynamic memory allocation in computer systems. It divides memory into blocks that are powers of two and tries to minimize fragmentation by splitting larger blocks into smaller ones when necessary. The Buddy System helps in managing free memory efficiently by merging adjacent free blocks when a process is freed.

Features:
* Allocates memory in blocks of size powers of two.
* Supports process allocation and deallocation.
* Displays memory status, including free blocks and allocated blocks.
* Handles internal fragmentation and memory block merging.

## 2-Memory Allocation Strategies
This section implements four classic memory allocation strategies for a simulated memory model:

* First Fit: Allocates the first available block that fits the process size.
* Best Fit: Allocates the smallest available block that fits the process size.
* Worst Fit: Allocates the largest available block, which can leave larger unallocated blocks.
* Next Fit: Similar to First Fit but starts searching from the last allocated position.

Each strategy shows how processes are allocated to available blocks and calculates the external fragmentation after allocation.

## 3-Page Replacement Algorithms
This section contains implementations of several page replacement algorithms used in operating systems to manage memory pages:

* FIFO (First In, First Out): Replaces the oldest page in memory when a page fault occurs.
* LRU (Least Recently Used): Replaces the page that hasn't been used for the longest time.
* Optimal: Replaces the page that will not be used for the longest time in the future.
* Clock: A circular version of the Second Chance algorithm, replacing the page with the oldest reference bit.
