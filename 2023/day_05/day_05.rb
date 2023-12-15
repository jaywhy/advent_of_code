def part_1(input)
  seeds, *sections = input.split("\n\n")

  seeds = seeds.split(":")[1].split(" ").map(&:to_i)
  sections.each do |section|
    ranges = []
    section.split("\n")[1..].each do |line|
      ranges << line.split(" ").map(&:to_i)
    end

    new = []
    seeds.each do |seed|
      range = ranges.find { |_, from, length| (from..from + length).include?(seed) }

      new << if range
               (range[0] - range[1]) + seed
             else
               seed
             end

    end

    seeds = new
  end

  pp seeds.min
end

def part_2(input)
  inputs, *sections = input.split("\n\n")

  inputs = inputs.split(":")[1].split(" ").map(&:to_i)

  seeds = inputs.each_slice(2).map { |start, length| (start..start + length) }

  sections.each do |section|
    ranges = []
    section.split("\n")[1..].each do |line|
      ranges << line.split(" ").map(&:to_i)
    end

    new = []
    while seeds.length.positive?
      seed = seeds.pop
      found = false
      ranges.each do |a, b, c|
        os = [seed.begin, b].max
        oe = [seed.end, b + c].min

        if os < oe
          new << ((os - b + a)..(oe - b + a))
          seeds << (seed.begin..os) if os > seed.begin
          seeds << (oe..seed.end) if oe < seed.end
          found = true
          break
        end
      end

      new << (seed.begin..seed.end) unless found
    end

    seeds = new
  end

  pp seeds.map(&:begin).min
end

input_test = <<~DATA
  seeds: 79 14 55 13

  seed-to-soil map:
  50 98 2
  52 50 48

  soil-to-fertilizer map:
  0 15 37
  37 52 2
  39 0 15

  fertilizer-to-water map:
  49 53 8
  0 11 42
  42 0 7
  57 7 4

  water-to-light map:
  88 18 7
  18 25 70

  light-to-temperature map:
  45 77 23
  81 45 19
  68 64 13

  temperature-to-humidity map:
  0 69 1
  1 0 69

  humidity-to-location map:
  60 56 37
  56 93 4
DATA

input = File.read("2023/day_05/input.txt")
part_2(input)
# pp part_2(input_test)