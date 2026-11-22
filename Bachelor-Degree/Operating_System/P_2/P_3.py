import time

def fifo(pages, capacity):
    memory = []  # لیست حافظه برای نگه داشتن صفحات
    page_faults = 0  # شمارنده وقفه‌های صفحه

    start_time = time.perf_counter()
    print("\nRunning FIFO page replacement:")
    for _, page in enumerate(pages):
        if page not in memory:  # اگر صفحه در حافظه نیست
            if len(memory) == capacity:  # اگر حافظه به ظرفیت کامل رسیده
                memory.pop(0)  # قدیمی‌ترین صفحه (اولین صفحه وارد شده) را حذف کن
            memory.append(page)  # افزودن صفحه جدید به حافظه
            page_faults += 1  # شمارنده وقفه‌های صفحه را افزایش بده
            print(f"Memory: {memory}, Page Faults: {page_faults}")
    
    end_time = time.perf_counter()
    print("FIFO page faults:", page_faults)
    print(f"Execution time: {end_time - start_time:.10f} seconds\n")

    return page_faults


def lru(pages, capacity):
    memory = [] 
    page_faults = 0  
    last_used = {}  # نگه‌داشتن آخرین زمان آخرین استفاده از هر صفحه

    start_time = time.perf_counter()
    print("Running LRU page replacement:")
    for times, page in enumerate(pages):  # حلقه با زمان (times) برای هر صفحه
        if page not in memory:
            if len(memory) == capacity:
                # پیدا کردن صفحه‌ای که برای مدت طولانی‌تر استفاده نشده است
                lru_page = min(last_used, key=last_used.get)
                memory.remove(lru_page)  # حذف صفحه‌ای که کمتر از همه اخیراً استفاده شده
                del last_used[lru_page]  # حذف از زمان استفاده

            memory.append(page)
            page_faults += 1
            print(f"Memory: {memory}, Page Faults: {page_faults}")

        # به‌روزرسانی زمان آخرین استفاده از صفحه
        last_used[page] = times

    end_time = time.perf_counter()
    print("LRU page faults:", page_faults)
    print(f"Execution time: {end_time - start_time:.10f} seconds\n")

    return page_faults


def optimal(pages, capacity):
    memory = []
    page_faults = 0

    start_time = time.perf_counter()
    print("Running Optimal page replacement:")
    for index, page in enumerate(pages):  # نیاز به index برای بررسی آینده
        if page not in memory:
            if len(memory) == capacity:
                farthest = -1  # بیشترین فاصله تا دسترسی بعدی
                replace_index = -1  # شاخص صفحه‌ای که باید جایگزین شود
                for j in range(len(memory)):
                    if memory[j] not in pages[index + 1:]:  # اگر صفحه در دسترسی‌های آینده وجود ندارد
                        replace_index = j  # صفحه باید حذف شود
                        break
                    else:  # در غیر این صورت فاصله تا استفاده بعدی را محاسبه کن
                        next_use = pages[index + 1:].index(memory[j])
                        if next_use > farthest:  # اگر فاصله تا استفاده بعدی بیشتر باشد
                            farthest = next_use
                            replace_index = j
                memory[replace_index] = page
            else:
                memory.append(page)
            page_faults += 1
            print(f"Memory: {memory}, Page Faults: {page_faults}")

    end_time = time.perf_counter()
    print("Optimal page faults:", page_faults)
    print(f"Execution time: {end_time - start_time:.10f} seconds\n")
    return page_faults


def clock(pages, capacity):
    memory = []
    use_bit = []
    pointer = 0  # اشاره‌گر به موقعیت فعلی در حلقه حافظه
    page_faults = 0

    start_time = time.perf_counter()
    print("\nRunning Clock page replacement:")
    for _, page in enumerate(pages):
        if page in memory:  # اگر صفحه در حافظه موجود است
            use_bit[memory.index(page)] = 1  # بیت استفاده آن را تنظیم کن
        else:  # اگر صفحه در حافظه نیست
            if len(memory) < capacity:
                memory.append(page)
                use_bit.append(1)
            else:
                while use_bit[pointer] == 1:  # به دنبال صفحه‌ای با بیت استفاده 0 بگرد
                    use_bit[pointer] = 0  # بیت استفاده فعلی را به 0 تنظیم کن
                    pointer = (pointer + 1) % capacity  # به موقعیت بعدی برو (حلقه‌ای)
                memory[pointer] = page
                use_bit[pointer] = 1  # بیت استفاده صفحه جدید را تنظیم کن 
                pointer = (pointer + 1) % capacity  # اشاره‌گر را جلو ببر
            page_faults += 1
            print(f"Memory: {memory} , Page Faults: {page_faults}")

    end_time = time.perf_counter()
    print("Clock page faults:", page_faults)
    print(f"Execution time: {end_time - start_time:.10f} seconds\n")
    return page_faults


def main():
    # دریافت ورودی از کاربر
    pages = list(map(int, input("Enter the page sequence (separated by space): ").split()))
    if any(page < 0 for page in pages):  # بررسی وجود مقادیر منفی
        print("Invalid input.")
        return
    capacity = int(input("Enter the memory capacity: "))
    if capacity <= 0:  # بررسی ظرفیت حافظه
        print("Invalid input.")
        return

    fifo_faults = fifo(pages, capacity)
    lru_faults = lru(pages, capacity)
    optimal_faults = optimal(pages, capacity)
    clock_faults = clock(pages, capacity)

    #  نتایج برای مقایسه
    print("\nComparison :")
    print("Optimal page faults:",optimal_faults,"\nLRU page faults:",lru_faults,"\nClock page faults:",clock_faults,"\nFIFO page faults:",fifo_faults)

main()