# 2430334
def part_1(input)
  left = []
  right = []

  input.each_line.each do |line|
    pair = line.split(" ").map(&:to_i)
    left << pair[0]
    right << pair[1]
  end

  left.sort.zip(right.sort).reduce(0) do |sum, (l, r)|
    sum + (r - l).abs
  end
end

# 28786472
def part_2(input)
  pairs = input.each_line.map { |line| line.split(" ").map(&:to_i) }
  right_tally = pairs.map(&:last).tally
  pairs.sum { |l, _| right_tally.fetch(l, 0) * l }
end

input_1 = File.read("2024/day_01/input.txt")
input_2 = File.read("2024/day_01/input2.txt")

pp part_1(input_1)
pp part_2(input_2)