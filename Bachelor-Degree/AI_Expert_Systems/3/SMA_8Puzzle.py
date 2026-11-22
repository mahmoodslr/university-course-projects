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
            neighbors.append(tuple(lst))
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

class Node:
    total_created = 0

    def __init__(self, state, parent, g, h):
        self.state       = state
        self.parent      = parent
        self.g           = g           
        self.h           = h                 
        self.f           = g + h             
        self.children    = []                 
        self.forgotten_f = float('inf')       

        Node.total_created += 1
        self.order = Node.total_created       

    def get_ancestors(self):
        visited = set()
        cur = self.parent
        while cur is not None:
            visited.add(cur.state)
            cur = cur.parent
        return visited

def sma_star(start, goal, max_nodes=50):
    if not is_solvable(start, goal):
        print("This puzzle is not solvable.")
        return None

    Node.total_created = 0
    start_h    = manhattan_heuristic(start, goal)
    root       = Node(start, None, 0, start_h)
    memory     = [root]     
    leaves     = [root]      
    def best_leaf():
        best = leaves[0]
        for node in leaves:
            if (node.f, node.order) < (best.f, best.order):
                best = node
        return best

    def worst_leaf():
        worst = leaves[0]
        for node in leaves:
            if (node.f, -node.order) > (worst.f, -worst.order):
                worst = node
        return worst

    def update_parent_f(node):
        cur = node
        while cur is not None:
            if cur.children:
                min_f = cur.forgotten_f
                for child in cur.children:
                    if child.f < min_f:
                        min_f = child.f
                cur.f = min_f
            else:
                cur.f = cur.forgotten_f
            cur = cur.parent

    while True:
        if not leaves:
            return None
        leaf = best_leaf()
        if leaf.state == goal:
            path = []
            cur = leaf
            while cur is not None:
                path.append(cur.state)
                cur = cur.parent
            path.reverse()
            return path
        if len(memory) >= max_nodes:
            if len(leaves) <= 1:
                return None 
            bad = worst_leaf()
            leaves.remove(bad)
            memory.remove(bad)
            if bad.parent is not None:
                p = bad.parent
                p.children.remove(bad)
                if bad.f < p.forgotten_f:
                    p.forgotten_f = bad.f
                if not p.children:
                    leaves.append(p)
                update_parent_f(p)
            continue  

        leaves.remove(leaf)
        ancestors = leaf.get_ancestors()
        for nb_state in get_neighbors(leaf.state):
            if nb_state in ancestors:
                continue  
            new_g = leaf.g + 1
            new_h = manhattan_heuristic(nb_state, goal)
            child = Node(nb_state, leaf, new_g, new_h)
            if child.f < leaf.f:
                child.f = leaf.f
            leaf.children.append(child)
            memory.append(child)
            leaves.append(child)
        if leaf.children:
            min_child_f = leaf.children[0].f
            for child in leaf.children:
                if child.f < min_child_f:
                    min_child_f = child.f
            leaf.f = min_child_f
        else:
            leaf.f = float('inf') 

def print_puzzle(state):
    for i in range(0, 9, 3):
        row = state[i:i+3]
        print(" ".join(str(x) if x != 0 else " " for x in row))
    print("-" * 10)

if __name__ == "__main__":
    start_state = (1, 2, 3, 4, 5, 6, 0, 7, 8)
    # start_state = (1, 2, 3, 4, 5, 6, 8, 7, 0)
    goal_state  = (1, 2, 3, 4, 5, 6, 7, 8, 0)
    print("Initial puzzle:")
    print_puzzle(start_state)
    path = sma_star(start_state, goal_state, max_nodes=20)
    if path:
        print(f"\nSolved in {len(path)-1} moves:\n")
        for step, state in enumerate(path):
            print(f"Step {step}:")
            print_puzzle(state)
    else:
        print("No solution found (try increasing max_nodes).")
