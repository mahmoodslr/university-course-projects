import random

MAP_HEIGHT = 11  # ارتفاع نقشه
POPULATION_SIZE = 50
GENERATIONS = 100
MUTATION_RATE = 0.1 # نرخ جهش

# نقشه شهر (11x10)
city_map = [
    ["5", "2", "4", "8", "9", "0", "3", "3", "8", "7"], 
    ["5", "5", "3", "4", "4", "6", "4", "1", "9", "1"], 
    ["4", "1", "2", "1", "3", "8", "7", "8", "9", "1"], 
    ["1", "7", "1", "6", "9", "3", "1", "9", "6", "9"], 
    ["=", "||", "=", "=", "=", "=", "||", "=", "=", "="],
    ["4", "7", "4", "9", "9", "8", "6", "5", "4", "2"], 
    ["7", "5", "8", "2", "5", "2", "3", "9", "8", "2"], 
    ["1", "4", "0", "6", "8", "4", "0", "1", "2", "1"], 
    ["1", "5", "2", "1", "2", "8", "3", "3", "6", "2"], 
    ["4", "5", "9", "6", "3", "9", "7", "6", "5", "10"], 
    ["0", "6", "2", "8", "7", "1", "2", "1", "5", "3"]
]

# مختصات پل ها
bridges = [(4, 1), (4, 6)]


# برسی قابل عبور بودن خانه ها
def is_accessible(cell):
    return cell != "="


# فاصله منهتن
def manhattan(a, b):
    return abs(a[0] - b[0]) + abs(a[1] - b[1])


# فاصله منهتن با در نظر گرفتن پل ها
def distance_with_bridge(start, end):
    x1, y1 = start
    x2, y2 = end
    # برسی اینکه آیا هر دو در یک سمت رودخانه هستند
    if (x1 != 4 and x2 != 4):
        return manhattan(start, end)
    # اگر در یک سمت نیستند
    min_dist = float('inf')
    for b in bridges:
        bridge_x, bridge_y = b
        # برسی قابل عبور بودن پل
        if is_accessible(city_map[bridge_x][bridge_y]):
            # فاصله از نقطه شروع تا پل
            to_bridge = manhattan(start, (bridge_x, bridge_y))
            # فاصله از پل تا نقطه انتها
            # اگر  بالای رودخانه است، باید به سطر 5 می رویم
            # اگر پایین رودخانه است، به سطر 3 می رویم
            from_bridge_x = bridge_x + 1 if x1 < 4 else bridge_x - 1
            from_bridge = manhattan((from_bridge_x, bridge_y), end)
            total = to_bridge + 1 + from_bridge 
            min_dist = min(min_dist, total)
    return min_dist


# تولید جمعیت اولیه
def create_population():
    population = []
    for p in range(POPULATION_SIZE):
        while True:
            x = random.randint(0, MAP_HEIGHT - 1) # سطر 0 تا 10
            y = random.randint(0, 9)  # ستون‌ ها 0 تا 9
            if is_accessible(city_map[x][y]):
                population.append((x, y))
                break
    return population


# فیتنس بر اساس فاصله با خطرات
def calculate_fitness(position):
    x0, y0 = position
    total_cost = 0
    for i in range(MAP_HEIGHT):
        for j in range(10):  # ستون‌ها
            cell = city_map[i][j]
            if i == 4:  # اگر خانه روی رودخانه است، آن را نادیده بگیر
                continue
            if cell.isdigit():
                risk = int(cell)
                dist = distance_with_bridge((x0, y0), (i, j))
                total_cost += dist * risk
    return total_cost



# انتخاب والدین
def select_parents(population):
    return random.sample(population, 2)


# کراس‌اور
def crossover(p1, p2):
    # سطر از والد اول، ستون از والد دوم
    child = (p1[0], p2[1])
    # برسی قابل دسترس بودن
    if is_accessible(city_map[child[0]][child[1]]):
        return child
    else:
        return p1  # در صورت قابل دسترس نبودن، والد اول را برمی‌گردانیم


# جهش
def mutate(individual):
    if random.random() < MUTATION_RATE:
        for m in range(10):
            x = random.randint(0, MAP_HEIGHT - 1)
            y = random.randint(0, 9)
            if is_accessible(city_map[x][y]):
                return (x, y)
    return individual


# الگوریتم ژنتیک
def genetic_algorithm():
    population = create_population()
    best_solution = None
    best_fitness = float("inf")
    for g in range(GENERATIONS):
        # مرتب‌ سازی بر اساس فیتنس
        population.sort(key=calculate_fitness)
        # بروزرسانی بهترین
        if calculate_fitness(population[0]) < best_fitness:
            best_fitness = calculate_fitness(population[0])
            best_solution = population[0]
        # نگهداری بهترین‌ ها
        new_population = population[:10]
        # تولید بقیه جمعیت
        while len(new_population) < POPULATION_SIZE:
            p1, p2 = select_parents(population)
            child = crossover(p1, p2)
            child = mutate(child)
            new_population.append(child)
        population = new_population
    return best_solution


# نقشه با مشخص بودن موقعیت بهترین ایستگاه آتش نشانی
def print_city_map_with_solution(position):
    for i in range(MAP_HEIGHT):
        row = ""
        for j in range(10):
            if (i, j) == position:
                row += " 🚒 "
            else:
                val = city_map[i][j]
                row += f" {val:>2}"
        print(row)


# اجرای برنامه

# مانریس امتیازات
fitness_matrix = [[calculate_fitness((i, j)) if i != 4 else None for j in range(10)] for i in range(MAP_HEIGHT)]

# نمایش ماتریس امتیاز Fitness
print("Fitness matrix:")
for row in fitness_matrix:
    print([val if val is not None else "X" for val in row])
## کمترین مقدار 2364 هست در [5,5]
print("\n ********** \n ")
best_pos = genetic_algorithm()
print("Best fire station location:", best_pos)
print("City map with fire station marked:")
print_city_map_with_solution(best_pos)
