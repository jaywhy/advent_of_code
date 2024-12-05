def part_1(input)
  rocks = input.split("\n").map { |line| line.split("") }
  calculate_total_load(tilt_north(rocks))
end

def part_2(input)
  rocks = input.split("\n").map { |line| line.split("") }

  x = 1000000000
  x.times do
    4.times do
      tilt_north(rocks)
      rocks = rocks.reverse.transpose
    end
  end

  calculate_total_load(rocks)
end

def display(rocks) = rocks.each { |row| p row }

def calculate_total_load(rocks)
  total_load = 0
  rocks.each_with_index do |row, x|
    row.each_with_index do |rock, y|
      next unless rock == "O"

      total_load += rocks.length - x
    end
  end

  total_load
end

def tilt_north(rocks)
  rocks.each_with_index do |row, i|
    row.each_with_index do |rock, j|
      next unless rock == "O"

      new_row = (0..i - 1).reverse_each.take_while { |r| rocks[r][j] == "." }.last

      if new_row
        rocks[i][j] = "."
        rocks[new_row][j] = rock
      end
    end
  end
end

input = File.read("2023/day_14/input.txt")
input_test = <<~DATA
  O....#....
  O.OO#....#
  .....##...
  OO.#O....O
  .O.....O#.
  O.#..O.#.#
  ..O..#O..O
  .......O..
  #....###..
  #OO..#....
DATA

p part_1(input)
p part_2(input_test)