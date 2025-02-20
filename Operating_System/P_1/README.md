# Reader-Writer Problem Implementations
This repository contains three implementations of the Reader-Writer problem in Python using different synchronization techniques such as locks and semaphores with the multiprocessing module. 
The Reader-Writer problem is a classic synchronization issue where multiple readers can access a shared resource simultaneously, but writers require exclusive access.

---
## Projects Overview:
### 1. ReaderWriterMonitor:
* Implements the Reader-Writer problem using Locks and Condition Variables for synchronization.
* A monitor lock ensures mutual exclusion for readers and writers.
* Uses multiprocessing.Value for shared variables and multiprocessing.Condition to handle waiting readers and writers.
* The readers are allowed to access the resource when no writer is active, and writers are blocked until there are no active readers.

### 2. ReaderWriterSemaphore:
* Implements the Reader-Writer problem using Semaphores for synchronization.
* A semaphore is used to control access to the shared resource, ensuring mutual exclusion for writers and allowing multiple readers to access the resource simultaneously.
* The reader count is managed with a semaphore, ensuring no writers can access the resource while readers are active.

### 3. WriterReaderSemaphore:
* Implements the Reader-Writer problem with a more complex use of multiple semaphores for advanced synchronization.
* In addition to the basic reader-writer synchronization, it introduces additional semaphores to better handle concurrent access to the resource.
* The semaphores are strategically used to prevent any writer from accessing the resource while readers are active and vice versa.

---

## Key Concepts:
* **Reader-Writer Problem:** A classic synchronization problem where multiple readers can read a shared resource simultaneously, but writers need exclusive access.
* **Locks:** Mutual exclusion mechanisms to ensure that only one thread can access a critical section at a time.
* **Semaphores:** A synchronization primitive that is used to control access to a shared resource by multiple processes or threads.
