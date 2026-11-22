import time
import copy

def validate_positive_integer(value, name):  # بررسی مقدار ورودی که باید عدد صحیح مثبت باشد
    if not isinstance(value, int) or value <= 0:
        raise ValueError(f"{name} must be a positive integer!")

def validate_non_negative_integer(value, name):  # بررسی مقدار ورودی که باید عدد صحیح غیرمنفی باشد
    if not isinstance(value, int) or value < 0:
        raise ValueError(f"{name} cannot be negative!")

def first_fit(memory_m, processes):
    allocation = [-1] * len(processes)  # ایجاد لیستی برای نگهداری محل تخصیص هر فرآیند (-1 یعنی تخصیص نیافته)
    for i in range(len(processes)):
        for idx, (start, end) in enumerate(memory_m):  # جستجو در بلوک‌های خالی حافظه
            block_size = end - start + 1  # محاسبه اندازه بلوک خالی
            if block_size >= processes[i]:  # اگر بلوک کافی باشد
                allocation[i] = start  # تخصیص شروع این بلوک به فرآیند
                if block_size > processes[i]:  # اگر بلوک بزرگتر از نیاز فرآیند باشد
                    memory_m[idx] = (start + processes[i], end)  # به‌روزرسانی بلوک خالی
                else:
                    del memory_m[idx]  # اگر دقیقاً برابر باشد، بلوک حذف می‌شود
                break  # فرآیند تخصیص داده شد، از حلقه خارج شو
    return allocation

def best_fit(memory_m, processes):
    allocation = [-1] * len(processes)
    for i in range(len(processes)):
        best_idx = -1  # شاخص بهترین بلوک
        best_size = float('inf')  # کوچک‌ترین بلوک ممکن که در ابتدا بی نهایت است

        for idx, (start, end) in enumerate(memory_m):
            block_size = end - start + 1
            if block_size >= processes[i] and block_size < best_size:  # کوچک‌ترین بلوک کافی
                best_idx = idx
                best_size = block_size

        if best_idx != -1:  # اگر بلوک مناسبی پیدا شد
            start, end = memory_m[best_idx]
            allocation[i] = start
            if best_size > processes[i]:
                memory_m[best_idx] = (start + processes[i], end)
            else:
                del memory_m[best_idx]

    return allocation

def worst_fit(memory_m, processes):
    allocation = [-1] * len(processes)
    for i in range(len(processes)):
        worst_idx = -1  # شاخص بزرگ‌ترین بلوک
        worst_size = -1  # بزرگ‌ترین بلوک ممکن

        for idx, (start, end) in enumerate(memory_m):
            block_size = end - start + 1
            if block_size >= processes[i] and block_size > worst_size:  # بزرگ‌ترین بلوک کافی
                worst_idx = idx
                worst_size = block_size

        if worst_idx != -1:  # اگر بلوک مناسبی پیدا شد
            start, end = memory_m[worst_idx]
            allocation[i] = start
            if worst_size > processes[i]:
                memory_m[worst_idx] = (start + processes[i], end)
            else:
                del memory_m[worst_idx]

    return allocation

def next_fit(memory_m, processes):
    allocation = [-1] * len(processes)
    last_idx = 0  # شاخص شروع جستجو که تخصیص از نقطه توقف قبلی ادامه می‌یابد

    for i in range(len(processes)):
        if not memory_m:
            break
        for _ in range(len(memory_m)):
            start, end = memory_m[last_idx]
            block_size = end - start + 1
            if block_size >= processes[i]:
                allocation[i] = start
                if block_size > processes[i]:
                    memory_m[last_idx] = (start + processes[i], end)
                else:
                    del memory_m[last_idx]
                break
            last_idx = (last_idx + 1) % len(memory_m)  # حرکت به بلوک بعدی

    return allocation

def calculate_external_f(memory_m):
    return sum(end - start + 1 for start, end in memory_m)

def generate_memory(total_memory, occupied_blocks):
    validate_positive_integer(total_memory, "Total memory size")

    memory_map = []
    start = 0
    for block in sorted(occupied_blocks):  # بلوک‌های اشغال‌شده را مرتب می‌کند
        occupied_start, occupied_end = block
        if (occupied_start > occupied_end) :
            raise ValueError(f"Invalid occupied block range: ({occupied_start}, {occupied_end}). Start should be less than or equal to End!")
        if occupied_start < 0 or occupied_end >= total_memory:
            raise ValueError(f"Occupied block ({occupied_start}, {occupied_end}) is out of memory bounds!")
        if start < occupied_start:
            memory_map.append((start, occupied_start - 1))  # اضافه کردن بلوک خالی
        start = occupied_end + 1
    if start < total_memory:  # بررسی فضای باقی‌مانده در انتها
        memory_map.append((start, total_memory - 1))
    return memory_map

def main():
    try:
        total_memory = int(input("Enter total memory size: "))
        validate_positive_integer(total_memory, "Total memory size")

        num_occupied_blocks = int(input("Enter number of occupied blocks: "))
        validate_non_negative_integer(num_occupied_blocks, "Number of occupied blocks")

        occupied_blocks = []
        for _ in range(num_occupied_blocks):
            occupied_start, occupied_end = map(int, input("Enter start and end of occupied block: ").split())
            occupied_blocks.append((occupied_start, occupied_end))

        memory_map = generate_memory(total_memory, occupied_blocks)

        num_processes = int(input("Enter number of processes: "))
        validate_non_negative_integer(num_processes, "Number of processes")

        processes = []
        for i in range(num_processes):
            process_size = int(input(f"Enter size of process {i + 1}: "))
            validate_positive_integer(process_size, f"Size of process {i + 1}")
            processes.append(process_size)

        algorithms = {
            "First Fit": first_fit,
            "Best Fit": best_fit,
            "Worst Fit": worst_fit,
            "Next Fit": next_fit
        }

        for name, algorithm in algorithms.items():
            print(f"\n{name}:")
            temp_memory_map = copy.deepcopy(memory_map)
            start_time = time.perf_counter()  # شروع زمان اجرای الگوریتم
            allocation = algorithm(temp_memory_map, processes)
            end_time = time.perf_counter()  # پایان زمان اجرای الگوریتم

            for i in range(len(processes)):
                print(f"Process {i + 1} -> {allocation[i] if allocation[i] != -1 else 'Not Allocated'}")

            fragmentation = calculate_external_f(temp_memory_map)
            print(f"External fragmentation: {fragmentation}")

            remaining_processes = [p for i, p in enumerate(processes) if allocation[i] == -1]
            largest_free_block = max((end - start + 1 for start, end in temp_memory_map), default=0)

            if remaining_processes and largest_free_block >= min(remaining_processes):
                print("Warning: External Fragmentation exists!")

            print(f"Execution time: {end_time - start_time:.10f} seconds")

    except ValueError as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()
