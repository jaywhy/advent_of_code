class Beam
  attr_accessor :x, :y, :direction

  def initialize(x, y, direction)
    @direction = direction
    @x = x
    @y = y

    case @direction
    when :right
      @x += 1
    when :left
      @x -= 1
    when :up
      @y -= 1
    when :down
      @y += 1
    end
  end
end

@step = 0

def part_1(input)
  grid = input.split("\n").map(&:chars)

  beams = [Beam.new(-1, 0, :right)]
  cache = {}

  until beams.empty?
    beam = beams.shift

    display(grid, beams, beam, cache)

    next if cache[[beam.x, beam.y]]

    cache[[beam.x, beam.y]] = true

    next if beam.x.negative? || beam.y.negative? || beam.x >= grid[0].length || beam.y >= grid.length

    case grid[beam.y][beam.x]
    when "|"
      # puts "found | splitting beam"
      beams << Beam.new(beam.x, beam.y, :down)
      beams << Beam.new(beam.x, beam.y, :up)
    when "-"
      # puts "found -"
      beams << Beam.new(beam.x, beam.y, :left)
      beams << Beam.new(beam.x, beam.y, :right)
    when "/"
      # puts "found /"
      case beam.direction
      when :right
        beams << Beam.new(beam.x, beam.y, :up)
      when :left
        beams << Beam.new(beam.x, beam.y, :down)
      when :up
        beams << Beam.new(beam.x, beam.y, :right)
      when :down
        beams << Beam.new(beam.x, beam.y, :left)
      end
    when "\\"
      # puts "found \\"
      case beam.direction
      when :right
        beams << Beam.new(beam.x, beam.y, :down)
      when :left
        beams << Beam.new(beam.x, beam.y, :up)
      when :up
        beams << Beam.new(beam.x, beam.y, :left)
      when :down
        beams << Beam.new(beam.x, beam.y, :right)
      end
    when "."
      # puts "found ."
      case beam.direction
      when :right
        grid[beam.y][beam.x] = ">"
      when :left
        grid[beam.y][beam.x] = "<"
      when :up
        grid[beam.y][beam.x] = "^"
      when :down
        grid[beam.y][beam.x] = "v"
      end

      beams << Beam.new(beam.x, beam.y, beam.direction)
      # pp beams
    else
      beams << Beam.new(beam.x, beam.y, beam.direction)
    end
  end

end

def display(grid, beams, beam, cache)
  system("clear")
  puts "Step: #{@step += 1}"
  puts (0..grid.length - 1).to_a.join("")
  grid.each_with_index { |row, i| print row.join(""), "#{i}\n" }
  p beams
  p beam
  p cache
  puts "Beam in cache: #{cache.key?([beam.x, beam.y])}"
  gets
end

input_test = File.read("2023/day_16/input_test.txt")
input = File.read("2023/day_16/input.txt")

part_1(input_test)