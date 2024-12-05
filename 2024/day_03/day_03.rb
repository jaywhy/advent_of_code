def part_1(input)
  input.scan(/mul\((\d+),(\d+)\)/).map { _1.to_i * _2.to_i }.sum
end

def part_2(input)
  toggle = true
  input.scan(/mul\((\d+),(\d+)\)|(don't\(\))|(do\(\))/).filter_map do |match|
    toggle = false if match[2]
    toggle = true if match[3]

    match[0].to_i * match[1].to_i if toggle
  end.sum
end

input_test = <<~DATA
  xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
DATA

input_test2 = <<~DATA
  xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
DATA

input_1 = File.read("2024/day_03/input.txt")
input_2 = File.read("2024/day_03/input.txt")

# pp part_1(input_1)
pp part_2(input_2)
