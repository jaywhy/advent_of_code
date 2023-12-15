def part_1(input)
  times, distances = input.split("\n").map { |line| line.split(":") }.map { |_, numbers| numbers.split(" ").map(&:to_i) }

  new_records = []
  times.zip(distances).each do |time, distance_record|
    new_records_count = 0
    1.upto(time).each do |button_hold|
      travel_time = time - button_hold
      new_distance = travel_time * button_hold

      new_records_count += 1 if new_distance > distance_record
      # puts "records: #{new_records_count} time: #{time}, button_hold: #{button_hold}, travel_time: #{travel_time}, new_distance: #{new_distance} distance_record: #{distance_record}"
    end

    new_records << new_records_count
  end

  new_records.reduce(&:*)
end

def part_2(input)
  time, distance_record = input.split("\n").map { |line| line.split(":") }.map { |_, numbers| numbers.split(" ").join("").to_i }

  1.upto(time).reduce(0) do |new_records_count, button_hold|
    travel_time = time - button_hold
    new_distance = travel_time * button_hold

    new_records_count += 1 if new_distance > distance_record
    new_records_count
  end
end


input_test = <<~DATA
  Time:      7  15   30
  Distance:  9  40  200
DATA

input = File.read("2023/day_06/input.txt")
# puts part_1(input)
puts part_2(input)