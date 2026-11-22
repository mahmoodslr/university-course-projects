import multiprocessing
import time

class ReaderWriterSemaphore:
    def __init__(self, readers_count, writers_count):
        self.readers_count = readers_count
        self.writers_count = writers_count
        # semaphores and shared variables
        self.reader_count = multiprocessing.Value('i', 0)
        self.wsem = multiprocessing.Semaphore(1)
        self.x = multiprocessing.Semaphore(1)
        # for calculating waiting times
        self.reader_wait_times = multiprocessing.Array('d', readers_count)
        self.writer_wait_times = multiprocessing.Array('d', writers_count)

    def reader(self, reader_id):
        start_wait = time.time()
        
        self.x.acquire()
        self.reader_count.value += 1
        if self.reader_count.value == 1:
            self.wsem.acquire()
        self.x.release()
        
        # calculate wait time
        wait_time = time.time() - start_wait
        self.reader_wait_times[reader_id] = wait_time
        
        # reading
        print(f"Reader {reader_id} is reading.")
        time.sleep(0.3)
        print(f"Reader {reader_id} finished reading.")
        
        # exit critical section
        self.x.acquire()
        self.reader_count.value -= 1
        if self.reader_count.value == 0:
            self.wsem.release()
        self.x.release()

    def writer(self, writer_id):
        start_wait = time.time()
        
        # wait to access wsem
        self.wsem.acquire()
        
        # calculate wait time
        wait_time = time.time() - start_wait
        self.writer_wait_times[writer_id] = wait_time
        
        # writing 
        print(f"Writer {writer_id} is writing.")
        time.sleep(0.4)
        print(f"Writer {writer_id} finished writing.")
        
        self.wsem.release()

    def run(self):
        processes = []
        
        # start reader processes
        for i in range(self.readers_count):
            p = multiprocessing.Process(target=self.reader, args=(i,))
            processes.append(p)
            p.start()
        
        # start writer processes
        for i in range(self.writers_count):
            p = multiprocessing.Process(target=self.writer, args=(i,))
            processes.append(p)
            p.start()
        
        # wait for all processes to finish
        for p in processes:
            p.join()
        
        # calculate average wait times
        avg_reader_wait = sum(self.reader_wait_times) / self.readers_count
        avg_writer_wait = sum(self.writer_wait_times) / self.writers_count
        print(f"Average reader wait time: {avg_reader_wait:.3f} seconds")
        print(f"Average writer wait time: {avg_writer_wait:.3f} seconds")

if __name__ == "__main__":
    # input number of readers and writers
    readers = 10  # fixed number of readers
    writers = int(input("Enter the number of writers: "))
    print(f"Number of readers: {readers}")
    print(f"Number of writers: {writers}")
    Semaphore = ReaderWriterSemaphore(readers, writers)
    Semaphore.run()