import heapq


def dijkstra_min_heat_loss(grid):
    pass


# Example grid from the problem
grid_str = """2413432311323
3215453535623
3255245654254
3446585845452
4546657867536
1438598798454
4457876987766
3637877979653
4654967986887
4564679986453
1224686865563
2546548887735
4322674655533"""

# Convert grid string to a 2D list of integers
grid = [list(map(int, list(line))) for line in grid_str.strip().split('\n')]

# Calculate minimum heat loss
min_heat_loss = dijkstra_min_heat_loss(grid)
print("Minimum Heat Loss:", min_heat_loss)


# def dijkstra_min_heat_loss(grid):
#     N = len(grid[0])  # Width of the grid
#     M = len(grid)     # Height of the grid

#     dirs = [(0, -1), (1, 0), (0, 1), (-1, 0)]  # Up, Right, Down, Left
#     start_x, start_y = 0, 0
#     target_x, target_y = N - 1, M - 1

#     # Initialize priority queue
#     heap = []
#     distances = {}

#     # Possible initial directions: Right (1) and Down (2)
#     for dir_index in [1, 2]:
#         dx, dy = dirs[dir_index]
#         new_x = start_x + dx
#         new_y = start_y + dy
#         if 0 <= new_x < N and 0 <= new_y < M:
#             total_cost = grid[new_y][new_x]
#             state = (new_x, new_y, dir_index, 1)
#             heapq.heappush(heap, (total_cost, state))
#             distances[state] = total_cost

#     while heap:
#         current_cost, (x, y, dir_index,
#                        consecutive_count) = heapq.heappop(heap)

#         # If reached destination
#         if x == target_x and y == target_y:
#             return current_cost

#         # Skip if a better path to this state has been found
#         if distances.get((x, y, dir_index, consecutive_count), float('inf')) < current_cost:
#             continue

#         # Possible moves
#         possible_moves = []

#         # Continue straight if not exceeded consecutive move limit
#         if consecutive_count < 3:
#             possible_moves.append((dir_index, consecutive_count + 1))

#         # Turn left and right
#         for turn in [-1, 1]:
#             new_dir_index = (dir_index + turn) % 4
#             possible_moves.append((new_dir_index, 1))

#         for new_dir_index, new_consecutive_count in possible_moves:
#             dx, dy = dirs[new_dir_index]
#             new_x = x + dx
#             new_y = y + dy

#             # Check boundaries
#             if 0 <= new_x < N and 0 <= new_y < M:
#                 new_cost = current_cost + grid[new_y][new_x]
#                 new_state = (new_x, new_y, new_dir_index,
#                              new_consecutive_count)

#                 # If a better path is found, add to the queue
#                 if distances.get(new_state, float('inf')) > new_cost:
#                     distances[new_state] = new_cost
#                     heapq.heappush(heap, (new_cost, new_state))

#     # If destination is unreachable
#     return -1
