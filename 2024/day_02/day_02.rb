def part_1(input)
  reports = input.each_line.map { _1.split(" ").map(&:to_i) }
  safe = reports.count

  reports.each do |levels|
    prev_level = levels[0]
    inc_or_dec = if levels[0] > levels[1]
                   :decreasing
                 else
                   :increasing
                 end

    levels.each_with_index do |level, i|
      next if levels[i + 1].nil?
      if (level - levels[i + 1]).abs > 3 || (level - levels[i + 1]).zero? || (inc_or_dec == :increasing && level > levels[i + 1]) || (inc_or_dec == :decreasing && level < levels[i + 1])
        pp "Unsafe index: #{i} #{levels} Level: #{level} Prev: #{prev_level} Next Level: #{level[i + 1]} Inc: #{inc_or_dec}"
        safe -= 1
        break
      end

      prev_level = level
    end
  end

  safe
end

def check_report(report)
  diffs = report.each_cons(2).map { |a, b| b - a }
  diffs.all? { |v| v != 0 && v.abs <= 3 && v.positive? == diffs.first.positive? }
end

def part_2(input)
  data = input.each_line.map { _1.split(" ").map(&:to_i) }
  data.map do |report|
    check_report(report) ||
      (0...report.size).any? do |i|
        check_report(report.first(i) + report.drop(i + 1))
      end
  end.count(true)
end

# def part_2_old(input)
#   reports = input.each_line.map { _1.split(" ").map(&:to_i) }
#   safe = reports.count
#
#   reports.each_with_index do |levels, j|
#     inc_or_dec = if levels[0] > levels[1]
#                    :decreasing
#                  else
#                    :increasing
#                  end
#     current_level = levels[0]
#     bad_level = false
#     fucked = false
#
#     levels.each_with_index do |level, i|
#       next if levels[i + 1].nil?
#       if (current_level - levels[i + 1]).abs > 3 || (current_level - levels[i + 1]).zero? || (inc_or_dec == :increasing && current_level > levels[i + 1]) || (inc_or_dec == :decreasing && current_level < levels[i + 1])
#         if bad_level
#           safe -= 1
#           current_level = levels[i + 1]
#           fucked = true
#           puts "!#{j} #{safe} #{levels} #{inc_or_dec}"
#           break
#         end
#         if i == 0
#           current_level = levels[i + 1]
#           inc_or_dec = if current_level > levels[i + 2]
#                          :decreasing
#                        else
#                          :increasing
#                        end
#         end
#
#         bad_level = true
#         next
#       end
#
#       current_level = levels[i + 1]
#     end
#
#     if !fucked
#       puts "#{j} #{safe} #{levels} #{inc_or_dec}"
#     end
#   end
#
#   safe
# end
#
def process_file
  input.each_line.map { |line| line.split(" ").map(&:to_i) }
end

input_test = <<~DATA
  28 35 38 40 43
  2 4 6 9 10 9
  2 4 6 9 10 9
  45 48 51 52 55 58 60 60
  49 52 54 57 58 61 64 68
  23 26 28 29 34
  2 5 5 8 9
  39 40 42 44 45 51 48
  27 24 26 29 30 33 36
  72 72 73 76 78
  12 16 17 18 21 24 27 30
  57 61 60 63 66
  65 70 73 75 77
  30 28 27 24 22 21 24
  17 16 15 13 11 8 7 7
  37 36 34 33 31 30 29 25
  93 91 90 87 80
  18 16 15 13 14 11
  86 83 80 80 77
  55 56 55 54 52
  90 90 89 86 84
  57 53 52 49 48 46 45
DATA
# 7 6 4 2 1
# 1 2 7 8 9
# 9 7 6 2 1
# 1 3 2 4 5
# 8 6 4 4 1
# 1 3 6 7 9

# input_1 = File.read("2024/day_02/input.txt")
input_2 = File.read("2024/day_02/input.txt")

# pp part_1(input_1)
pp part_2(input_2)
puts "fuck"

