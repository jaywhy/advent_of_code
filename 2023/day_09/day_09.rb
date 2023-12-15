def part_1(input)
  history = input.split("\n").map { |line| line.split(" ").map(&:to_i) }

  sequences = []
  history.each do |values|
    sequence = [values]
    current_values = values
    until !current_values.empty? && current_values.all?(&:zero?)
      differences = []
      current_values.each_cons(2) do |previous, current|
        differences << current - previous
      end

      current_values = differences
      sequence << differences
    end

    sequences << sequence
  end

  sequences.each do |s|
    p s
  end
  sequences.map do |sequence|
    last_values = sequence.map(&:last).reverse
    last_values.reduce(0) do |x, value|
      x += value
      x
    end
  end.sum
end

def part_2(input)
end

input_test = <<~DATA
  0 3 6 9 12 15
  1 3 6 10 15 21
  10 13 16 21 30 45
DATA

input = File.read("2023/day_09/input.txt")
p part_1(input_test)