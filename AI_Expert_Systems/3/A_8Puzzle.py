import heapq

def index_to_rc(idx):
    return divmod(idx, 3)

def manhattan_heuristic(state, goal):
    total = 0
    for i in range(9):
        if state[i] == 0:
            continue
        r_cur, c_cur = index_to_rc(i)
        for j in range(9):
            if goal[j] == state[i]:
                r_goal, c_goal = index_to_rc(j)
                total += abs(r_cur - r_goal) + abs(c_cur - c_goal)
                break
    return total

def get_neighbors(state):
    blank_idx = state.index(0)
    r, c = index_to_rc(blank_idx)
    neighbors = []
    moves = [(-1, 0), (1, 0), (0, -1), (0, 1)]
    for dr, dc in moves:
        nr, nc = r + dr, c + dc
        if 0 <= nr < 3 and 0 <= nc < 3:
            new_idx = nr * 3 + nc
            lst = list(state)
            lst[blank_idx], lst[new_idx] = lst[new_idx], lst[blank_idx]
            neighbors.append((tuple(lst), 1))
    return neighbors

def is_solvable(state, goal):
    def inversion_count(seq):
        inv = 0
        for i in range(len(seq)):
            for j in range(i + 1, len(seq)):
                if seq[i] > seq[j]:
                    inv += 1
        return inv
    state_no_zero = [x for x in state if x != 0]
    goal_no_zero  = [x for x in goal  if x != 0]
    return inversion_count(state_no_zero) % 2 == inversion_count(goal_no_zero) % 2

def a_star_8_puzzle(start, goal):
    if not is_solvable(start, goal):
        print("This puzzle is not solvable.")
        return None
    counter = 0
    start_h = manhattan_heuristic(start, goal)
    frontier = []
    heapq.heappush(frontier, (start_h, counter, 0, start))
    came_from  = {start: None}
    cost_so_far = {start: 0}

    while frontier:
        f, _, g, current = heapq.heappop(frontier)
        if current == goal:
            path = []
            while current is not None:
                path.append(current)
                current = came_from[current]
            path.reverse()
            return path
        if g > cost_so_far[current]:
            continue
        for neighbor, step_cost in get_neighbors(current):
            new_g = g + step_cost
            if neighbor not in cost_so_far or new_g < cost_so_far[neighbor]:
                cost_so_far[neighbor] = new_g
                new_h = manhattan_heuristic(neighbor, goal)
                new_f = new_g + new_h
                counter += 1
                heapq.heappush(frontier, (new_f, counter, new_g, neighbor))
                came_from[neighbor] = current
    return None

def print_puzzle(state):
    for i in range(0, 9, 3):
        row = state[i:i+3]
        print(" ".join(str(x) if x != 0 else " " for x in row))
    print("-" * 10)

if __name__ == "__main__":
    start_state = (1, 2, 3, 4, 0, 6, 7, 5, 8)
    # start_state = (1, 2, 3, 4, 5, 6, 8, 7, 0)
    goal_state  = (1, 2, 3, 4, 5, 6, 7, 8, 0)
    print("Initial puzzle:")
    print_puzzle(start_state)
    path = a_star_8_puzzle(start_state, goal_state)

    if path:
        print(f"\nOptimal path with {len(path)-1} moves found:\n")
        for step, state in enumerate(path):
            print(f"Step {step}:")
            print_puzzle(state)
    else:
        print("Path not found.")