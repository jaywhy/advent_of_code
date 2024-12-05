def xmas?(puzzle, x, y, char)
  return false if x.negative? || y.negative?

  puzzle[y]&.[](x) == char
end

def part_1(input)
  puzzle = input.each_line.map { _1.chomp.chars }

  directions = [
    [-1, -1], [0, -1], [-1, 1],
    [-1, 0],           [1, 0],
    [1, -1], [0, 1], [1, 1]
  ]
  puzzle.each.with_index.sum do |row, y|
    row.each.with_index.sum do |cell, x|
      next 0 unless cell == "X"

      directions.count do |direction|
        dx, dy = direction

        "MAS".each_char.with_index.all? do |char, i|
          y_coord = y + dy * (i + 1)
          x_coord = x + dx * (i + 1)

          xmas?(puzzle, x_coord, y_coord, char)
        end
      end
    end
  end
end

def cross?(puzzle, x, y)
  return false if x.negative? || y.negative?

  cross_patterns = [
    %w[M M S S],
    %w[S S M M],
    %w[M S M S],
    %w[S M S M]
  ]
  top_left = puzzle[y - 1][x - 1]
  top_right = puzzle[y - 1][x + 1]
  bottom_left = puzzle[y + 1][x - 1]
  bottom_right = puzzle[y + 1][x + 1]

  pattern = [top_left, top_right, bottom_left, bottom_right]

  cross_patterns.include?(pattern)
end

def part_2(input)
  puzzle = input.each_line.map { _1.chomp.chars }

  (1..(puzzle.size - 2)).sum do |y|
    (1..(puzzle[y].size - 2)).count { |x| puzzle[y][x] == "A" && cross?(puzzle, x, y) }
  end
end

input_test = <<~DATA
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
DATA

input_test2 = <<~DATA
M.S
.A.
M.S
DATA

input_1 = File.read("2024/day_04/input.txt")
# input_2 = File.read("2024/day_04/input.txt")

pp part_1(input_test)
pp part_1(input_1)
# 1874 is too high
pp part_2(input_test)
# 1873
pp part_2(input_1)
