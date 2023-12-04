input_1 = <<~DATA
  1abc2
  pqr3stu8vwx
  a1b2c3d4e5f
  treb7uchet
DATA

input_2 = <<~DATA
  two1nine
  eightwothree
  abcone2threexyz
  xtwone3four
  4nineeightseven2
  zoneight234
  7pqrstsixteen
DATA

WORD_TO_NUMBER = {
  "one" => "1",
  "two" => "2",
  "three" => "3",
  "four" => "4",
  "five" => "5",
  "six" => "6",
  "seven" => "7",
  "eight" => "8",
  "nine" => "9"
}.freeze

input = File.read("day_01/input.txt")

def part_1(input)
  input.each_line.map do |line|
    digits = line.scan(/\d/)
    (digits[0] + digits[-1]).to_i
  end.sum
end

def part_2(input)
  input.each_line.map do |line|
    number_finder = /(?=(\d|#{Regexp.union(WORD_TO_NUMBER.keys)}))/
    digits = line.scan(number_finder).flatten
    (translate_number(digits[0]) + translate_number(digits[-1])).to_i
  end.sum
end

def translate_number(value)
  WORD_TO_NUMBER.key?(value) ? WORD_TO_NUMBER[value] : value
end

puts part_1(input)
puts part_2(input)
