import multiprocessing
import time

class ReaderWriterMonitor:
    def __init__(self, readers_count, writers_count):
        self.readers_count = readers_count
        self.writers_count = writers_count
        # shared variables and locks
        self.reader_count = multiprocessing.Value('i', 0)
        self.writer_active = multiprocessing.Value('b', False)  # indicates if a writer is active
        self.monitor_lock = multiprocessing.Lock()  # lock for monitor
        self.read_condition = multiprocessing.Condition(self.monitor_lock)
        self.write_condition = multiprocessing.Condition(self.monitor_lock)
        # for calculating waiting times
        self.reader_wait_times = multiprocessing.Array('d', readers_count)
        self.writer_wait_times = multiprocessing.Array('d', writers_count)

    def start_reading(self, reader_id):
        start_wait = time.time()

        with self.monitor_lock:
            while self.writer_active.value:  # wait if a writer is active
                self.read_condition.wait()

            # reader enters
            with self.reader_count.get_lock():
                self.reader_count.value += 1

        # calculate wait time
        wait_time = time.time() - start_wait
        self.reader_wait_times[reader_id] = wait_time

    def stop_reading(self):
        with self.monitor_lock:
            with self.reader_count.get_lock():
                self.reader_count.value -= 1
                if self.reader_count.value == 0:
                    self.write_condition.notify()  # notify writers if no readers 

    def start_writing(self, writer_id):
        start_wait = time.time()

        with self.monitor_lock:
            while self.reader_count.value > 0 or self.writer_active.value:  # wait if readers or another writer is active
                self.write_condition.wait()

            # writer enters
            self.writer_active.value = True

        # calculate wait time
        wait_time = time.time() - start_wait
        self.writer_wait_times[writer_id] = wait_time

    def stop_writing(self):
        with self.monitor_lock:
            self.writer_active.value = False
            self.read_condition.notify_all()  # notify all readers
            self.write_condition.notify()  # notify next writer

    def reader(self, reader_id):
        self.start_reading(reader_id)

        # reading
        print(f"Reader {reader_id} is reading.")
        time.sleep(0.3)
        print(f"Reader {reader_id} finished reading.")

        self.stop_reading()

    def writer(self, writer_id):
        self.start_writing(writer_id)

        # writing
        print(f"Writer {writer_id} is writing.")
        time.sleep(0.4)
        print(f"Writer {writer_id} finished writing.")

        self.stop_writing()

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
    monitor = ReaderWriterMonitor(readers, writers)
    monitor.run()