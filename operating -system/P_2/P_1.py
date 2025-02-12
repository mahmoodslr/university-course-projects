import math

class BuddySystem:
    def __init__(self, total_memory):
        self.total_memory = total_memory  # مقدار کل حافظه را ذخیره می‌کند
        self.free_blocks = {total_memory: [0]}  #  اندازه بلوک‌ها را به لیست آدرس‌های شروع بلوک‌های آزاد نگه می‌دارد(در ابتدا حافظه کامل یک بلوک آزاد است و از آدرس ۰ شروع می‌شود)
        self.allocated_blocks = {}  # فرآیندها را به آدرس تخصیص داده‌شده و اندازه بلوک و فضای هدر رفته نگه می‌دارد

    def allocate(self, process_id, process_size):
        block_size = 2 ** math.ceil(math.log2(process_size))   # کوچک‌ترین بلوک توان 2 که بتواند فرآیند را جای دهد

        if block_size > self.total_memory:  # اگر اندازه بلوک بزرگتر از کل حافظه باشد، تخصیص ممکن نیست
            print(f"1: Process {process_id}: Requested size {process_size} exceeds total memory.")
            return False

        suitable_block = None  # پیدا کردن یک بلوک آزاد مناسب

        for size in sorted(self.free_blocks):   # مرتب‌سازی بلوک‌های آزاد و یافتن اولین بلوک مناسب
            if size >= block_size and self.free_blocks[size]:
                suitable_block = size
                break

        if suitable_block is None:   # اگر بلوک مناسبی پیدا نشود، پیام خطا چاپ می‌شود
            print(f"2: Process {process_id}: No suitable block found for size {process_size}.")
            return False

        start_address = self.free_blocks[suitable_block].pop(0)  # آدرس شروع بلوک انتخاب‌شده

        # اگر بلوک‌های با اندازه انتخاب‌شده تمام شوند، آن اندازه حذف می‌شود
        if not self.free_blocks[suitable_block]:
            del self.free_blocks[suitable_block]

        while suitable_block > block_size:  # تقسیم بلوک‌ها به بلوک‌های کوچکتر تا رسیدن به اندازه موردنیاز
            suitable_block //= 2
            buddy_address = start_address + suitable_block  # آدرس بادی بلوک
            if suitable_block not in self.free_blocks:
                self.free_blocks[suitable_block] = []
            self.free_blocks[suitable_block].append(buddy_address)  # اضافه کردن بلوک جدید به بلوک‌های آزاد

        internal_fragmentation = block_size - process_size  # محاسبه فضای هدر رفته
        self.allocated_blocks[process_id] = (start_address, block_size, internal_fragmentation)  # ذخیره اطلاعات تخصیص به فرآیندهای تخصیص‌ داده‌شده
        print(f"3: Process {process_id}: Allocated {block_size} bytes at address {start_address}. Internal fragmentation: {internal_fragmentation} bytes.")
        return True

    def free(self, process_id):
        if process_id not in self.allocated_blocks:   # بررسی اینکه فرآیند در لیست تخصیص‌یافته‌ها وجود داشته باشد
            print(f"4: Process {process_id}: Not found in allocated blocks.")
            return False

        start_address, block_size, _ = self.allocated_blocks.pop(process_id)
        print(f"5: Process {process_id}: Freed {block_size} bytes from address {start_address}.")

        # متغیرهای موقت برای بررسی ادغام بلوک‌های آزاد
        current_address = start_address
        current_size = block_size

        while True:
            # آدرس بادی بلوک فعلی
            buddy_address = current_address ^ current_size
            buddy_list = self.free_blocks.get(current_size, [])

            if buddy_address in buddy_list:  # اگر بادی بلوک در لیست بلوک‌های آزاد وجود داشته باشد آن‌ها را ادغام می‌کند
                buddy_list.remove(buddy_address)
                if not buddy_list:
                    del self.free_blocks[current_size]

                # به‌روزرسانی آدرس و اندازه بلوک پس از ادغام
                current_address = min(current_address, buddy_address)
                current_size *= 2
            else:
                # اگر بادی پیدا نشود بلوک فعلی به لیست بلوک‌های آزاد اضافه می‌شود
                if current_size not in self.free_blocks:
                    self.free_blocks[current_size] = []
                self.free_blocks[current_size].append(current_address)
                break

        return True

    def status(self):
        print("\nMemory Status:")
        print("Free Blocks:")
        for size, addresses in sorted(self.free_blocks.items()):
            print(f"  Size {size}: {addresses}")
        print("Allocated Blocks:")
        for process_id, (start_address, block_size, internal_fragmentation) in self.allocated_blocks.items():
            print(f"  Process {process_id}: {block_size} bytes at address {start_address}, Internal fragmentation: {internal_fragmentation} bytes")

def is_power_of_two(num):
    return num > 0 and (2 ** round(math.log2(num))) == num  # بررسی اینکه عدد واردشده توان 2 است یا خیر

if __name__ == "__main__":
    while True:
        total_memory = int(input("Enter total memory size (bytes): "))
        
        if is_power_of_two(total_memory):
            break
        else:
            print("Invalid memory size. Please enter a value that is a power of 2 (for example -> 128, 256, 512 ...).")

    manager = BuddySystem(total_memory)

    while True:
        print("\nOptions: 1 (allocate), 2 (free), 3 (status), 4 (exit)")
        choice = input("Enter your choice: ").strip()

        if choice == "1":
            process_id = input("Enter process ID: ").strip()
            process_size = int(input("Enter process size (bytes): "))
            manager.allocate(process_id, process_size)

        elif choice == "2":
            process_id = input("Enter process ID to free: ").strip()
            manager.free(process_id)

        elif choice == "3":
            manager.status()

        elif choice == "4":
            break

        else:
            print("Invalid choice. Try again.")
