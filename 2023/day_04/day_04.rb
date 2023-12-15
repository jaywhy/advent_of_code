# frozen_string_literal: true

def part_1(input)
  input.each_line.reduce(0) do |total, line|
    winning_cards, numbers_you_have = line.sub(/^Card\s+\d+:\s+/, "")
                                          .split(" | ")
                                          .map { |card| card.split(" ").map(&:to_i) }

    points = winning_cards.intersection(numbers_you_have).size

    score = points.positive? ? 2**(points - 1) : 0
    total += score
    total
  end
end

def part_2(input)
  scratchcard_tally = {}
  input.each_line.reduce(0) do |total, line|
    card_number = line.match(/^Card\s+(\d+):/)[1].to_i
    winning_cards, numbers_you_have = line.sub(/^Card\s+\d+:\s+/, "")
                                          .split(" | ")
                                          .map { |card| card.split(" ").map(&:to_i) }

    points = winning_cards.intersection(numbers_you_have).size

    current_card_tally = scratchcard_tally.fetch(card_number, 0) + 1
    total_cards = (card_number + 1..points + card_number).to_a
    current_card_tally.times { total_cards.tally(scratchcard_tally) }
    [card_number].tally(scratchcard_tally)
    scratchcard_tally.values.sum
  end
end

input_1 = <<~DATA
  Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
  Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
  Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
  Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
  Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
  Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
DATA

input = File.read("2023/day_04/input2.txt")
# part_1_attempt_2(input)
pp part_1(input)
pp part_2(input)
