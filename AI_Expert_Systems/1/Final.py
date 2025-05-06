import math

class Node:
    def __init__(self, path, g_cost, h_cost):
        self.path = path  # مسیر طی‌شده تاکنون
        self.g = g_cost  # هزینه واقعی g(n)
        self.h = h_cost  # هزینه تخمینی h(n)
        self.f = g_cost + h_cost  # f(n) = g + h

# تابع اضافه کردن نود به لیست با ترتیب اولویت (f کمینه)
def priority_push(queue, node):
    queue.append(node)

# تابع برداشتن نود با کم‌ترین مقدار f از لیست
def priority_pop(queue):
    min_index = 0
    for i in range(1, len(queue)):
        if queue[i].f < queue[min_index].f:
            min_index = i
    return queue.pop(min_index)

# خواندن داده‌ها از فایل ورودی
def read_input(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()
    # تعداد شهر ها
    n = int(lines[0])
    # نام شهر ها
    cities = lines[1].split()  # از یکدیگر متمایز می شوند space نام شهر ها با
    adjacency_matrix = [list(map(float, line.split())) for line in lines[2:]]  # ماتریس فاصله
    return cities, adjacency_matrix

# تابع هیوریستیک
def mst_heuristic(unvisited, adjacency_matrix, current_city, start_city):
    if not unvisited:
        return adjacency_matrix[current_city][start_city]  # فقط برگشت به مبدا
    visited = set()
    total_cost = 0
    visited.add(unvisited[0])
    while len(visited) < len(unvisited):
        min_edge = float('inf')
        next_city = None
        for u in visited:
            for v in unvisited:
                if v not in visited and adjacency_matrix[u][v] < min_edge:
                    min_edge = adjacency_matrix[u][v]
                    next_city = v
        visited.add(next_city)
        total_cost += min_edge
    # اضافه کردن هزینه از شهر فعلی به نزدیک‌ترین unvisited
    min_start_to_unvisited = min([adjacency_matrix[current_city][u] for u in unvisited])
    # اضافه کردن هزینه برگشت از یکی از unvisited به مبدا
    min_unvisited_to_start = min([adjacency_matrix[u][start_city] for u in unvisited])
    return total_cost + min_start_to_unvisited + min_unvisited_to_start

# A*
def a_star_tsp(cities, adjacency_matrix):
    n = len(cities)
    start_city = 0
    OPEN = []  # step 1: صف گره‌های در حال بررسی
    CLOSED = []  # step 4: گره‌های بررسی‌شده
    # step 1: قرار دادن گره اولیه در OPEN
    start_node = Node([start_city], 0, mst_heuristic(list(range(1, n)), adjacency_matrix, start_city, start_city))
    priority_push(OPEN, start_node)
    while OPEN:  # step 2
        current = priority_pop(OPEN)  # step 4: برداشتن گره با f کمینه
        CLOSED.append(current)
        if len(current.path) == n:  # step 5: اگر گره هدف است
            total_cost = current.g + adjacency_matrix[current.path[-1]][start_city]
            print("Best path A*:", ' -> '.join([cities[i] for i in current.path] + [cities[start_city]]))
            print("Total cost:", round(total_cost, 2))
            return
        # step 7: گسترش گره
        for next_city in range(n):  # step 8
            if next_city not in current.path:
                new_path = current.path + [next_city]
                g_new = current.g + adjacency_matrix[current.path[-1]][next_city]
                unvisited = [i for i in range(n) if i not in new_path] 
                h_new = mst_heuristic(unvisited, adjacency_matrix, next_city, start_city) # step 9
                successor = Node(new_path, g_new, h_new)  # f(n') = g + h
                # step 10: بررسی وجود در OPEN و CLOSED
                in_open = next((node for node in OPEN if node.path == successor.path), None)
                in_closed = next((node for node in CLOSED if node.path == successor.path), None)
                if not in_open and not in_closed:  # step 11
                    priority_push(OPEN, successor)  # افزودن به OPEN
                else:
                    # step 14: اگر f جدید بهتر بود، مقدار جدید را اختصاص بده
                    target = in_open or in_closed
                    if successor.f < target.f:
                        target.g = g_new
                        target.h = h_new
                        target.f = g_new + h_new
                        target.path = new_path
                        # step 15: اگر در CLOSED بود، برش گردون به OPEN
                        if in_closed:
                            CLOSED.remove(target)
                            priority_push(OPEN, target)
    print("No solution found!!!")  # step 3

# RBFS
def RBFS(problem, node, f_limit, adjacency_matrix, n, start_city):  # step 1
    # step 2: اگر گره هدف است
    if len(node.path) == n:
        total_cost = node.g + adjacency_matrix[node.path[-1]][start_city]
        return node.path + [start_city], total_cost, total_cost
    successors = []  # step 3: لیست فرزندان
    # step 4,5 
    for next_city in range(n):
        if next_city not in node.path:
            new_path = node.path + [next_city]
            g_new = node.g + adjacency_matrix[node.path[-1]][next_city]
            unvisited = [i for i in range(n) if i not in new_path]
            h_new = mst_heuristic(unvisited, adjacency_matrix, next_city, start_city)
            successor = Node(new_path, g_new, h_new)
            # step 8: شرط pathmax modification( s.f ← max(s.g + s.h, node.f) ) 
            successor.f = max(successor.f, node.f)
            successors.append(successor)
    # step 6: گره بن بسته
    if not successors:
        return None, math.inf, math.inf
    while True:  # step 9
        # step 10
        successors.sort(key=lambda x: x.f)
        best = successors[0]
        # step 11
        if best.f > f_limit:
            return None, best.f, best.f
        # step 12: جایگزین دوم
        alternative = successors[1].f if len(successors) > 1 else math.inf
        # step 13
        result, best_new_f, result_cost = RBFS(problem, best, min(f_limit, alternative), adjacency_matrix, n, start_city)
        if result is not None:  # اگر موفق بود، مسیر و هزینه را بازگردان
            return result, best_new_f, result_cost
        best.f = best_new_f  # به‌روزرسانی f نود

def rbfs_tsp(cities, adjacency_matrix):
    n = len(cities)
    start_city = 0
    start_node = Node([start_city], 0, mst_heuristic(list(range(1, n)), adjacency_matrix, start_city, start_city))
    # step 2: فراخوانی return RBFS(problem, MAKE-NODE(...), ∞)
    path, _, cost = RBFS(None, start_node, math.inf, adjacency_matrix, n, start_city)
    if path:
        print("Best path RBFS:", ' -> '.join([cities[i] for i in path]))
        print("Total cost:", round(cost, 2))
    else:
        print("No solution found!!!")

if __name__ == "__main__":
    file_path = "test3.txt"  # نام فایل ورودی
    cities, adjacency_matrix = read_input(file_path)
    a_star_tsp(cities, adjacency_matrix)
    rbfs_tsp(cities, adjacency_matrix)
