Coordinate = Struct.new(:start_pos, :end_pos, :y)

def part_1(input)
  symbols_locations = process_symbols_locations(input)
  numbers = []
  gears = Hash.new { |h, k| h[k] = [] }
  gear_ratios = []

  input.each_line.with_index do |line, y|
    number = []
    coord = Coordinate.new
    line.each_char.with_index do |char, x|
      if number?(char)
        coord.start_pos = x if number.empty?
        coord.end_pos = x
        coord.y = y

        number << char
      else
        unless number.empty?
          numbers << number.join("").to_i if next_to_symbol?(coord, symbols_locations)
          gear = find_gear(coord, symbols_locations)
          gears[gear[0]] << number.join("").to_i if gear
        end

        coord = Coordinate.new
        number = []
      end
    end
  end

  gears.each do |_, gear_numbers|
    gear_ratios << gear_numbers.reduce(:*) if gear_numbers.size == 2
  end

  [numbers.sum, gear_ratios.sum]
end

def number?(char) = char.match?(/\d/)

def symbol?(char) = %w[* & $ - + % / # = @].include?(char)

def next_to_symbol?(coord, symbols_locations)
  symbols_locations.any? do |symbol_pos, _|
    x, y = symbol_pos
    x.between?(coord.start_pos - 1, coord.end_pos + 1) && y.between?(coord.y - 1, coord.y + 1)
  end
end

def find_gear(coord, symbols_locations)
  symbols_locations.detect do |symbol_pos, symbol|
    x, y = symbol_pos
    x.between?(coord.start_pos - 1, coord.end_pos + 1) && y.between?(coord.y - 1, coord.y + 1) && symbol == "*"
  end
end

def process_symbols_locations(input)
  input.each_line.each_with_object({}).with_index do |(line, symbol_locations), y|
    line.each_char.with_index do |char, x|
      next unless symbol?(char)

      symbol_locations[[x, y]] ||= char
    end
  end
end

input_1 = <<~DATA
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
DATA

input = File.read("2023/day_03/input.txt")
pp part_1(input)
