input_1 = <<~DATA
  Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
  Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
  Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
  Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
DATA

input = File.read("2023/day_02/input.txt")

def part_1(input)
  input.each_line.map do |line|
    game_id, plays = parse_game(line)
    plays = parse_plays(plays)
    possible_game?(plays) ? game_id.to_i : 0
  end.sum
end

def part_2(input)
  input.each_line.map do |line|
    game_id, plays = parse_game(line)
    plays = parse_plays(plays)

    game =
      plays.each_with_object(Hash.new(0)) do |play, max_value|
        %w[red green blue].each do |color|
          max_value[color] = [play[color], max_value[color]].max
        end
      end

    game.values.reduce(&:*)
  end.sum
end

def possible_game?(plays)
  plays.all? { |play| play["red"] <= 12 && play["green"] <= 13 && play["blue"] <= 14 }
end

def parse_game(line)
  line.scan(/Game (\d+): (.*)/).flatten
end

def parse_plays(plays)
  plays.split(/; /).map do |play|
    play.split(/, /).each_with_object(Hash.new(0)) do |roll, game|
      roll_parts = roll.scan(/(\d+) (\w+)/).flatten
      game[roll_parts[1]] += roll_parts[0].to_i
    end
  end
end

pp part_2(input)
