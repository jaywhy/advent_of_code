# frozen_string_literal: true

class Hand
  HAND_TYPE = %i[HC 1P 2P 3K FH 4K 5K].freeze
  CARD_STRENGTH = %w[J 2 3 4 5 6 7 8 9 T Q K A].freeze
  CARD_STRENGTH_PART_1 = %w[2 3 4 5 6 7 8 9 T J Q K A].freeze

  attr_reader :cards, :bid

  def initialize(cards, bid)
    @cards = cards
    @bid = bid
  end

  def card_type
    if card_counts.max == 5
      :"5K"
    elsif card_counts.max == 4
      :"4K"
    elsif card_counts.include?(3) && card_counts.include?(2)
      :FH
    elsif card_counts.max == 3
      :"3K"
    elsif card_counts.sort == [1, 2, 2]
      :"2P"
    elsif card_counts.sort == [1, 1, 1, 2]
      :"1P"
    else
      :HC
    end
  end

  def card_counts
    if joker?
      puts tally.inspect
      tally[max_card] += tally["J"]
      tally.delete("J")
    end

    tally.values
  end

  def joker? = tally.include?("J")

  def tally = @tally ||= cards.split("").tally

  def max_card = tally.max_by { |i| i[1] }[0]

  def card_type_rank = HAND_TYPE.find_index(card_type)

  def card_strengths = card_array.map { CARD_STRENGTH.find_index(_1) }

  def card_array = cards.split("")

  def card_type_index = HAND_TYPE.find_index(card_type)
end

def part_01(input)
  hands = input.split("\n").map { _1.split(" ") }.map { |hand| Hand.new(hand[0], hand[1].to_i) }
  ranked_hands = hands.sort_by { |hand| [hand.card_type_rank, hand.card_strengths] }

  ranked_hands.each do |hand|
    puts "#{hand.cards} #{hand.tally.max} #{hand.card_type} #{hand.card_type_rank} #{hand.card_strengths}"
  end

  ranked_hands.map.with_index do |hand, i|
    hand.bid * (i + 1)
  end.sum
end

input_test = <<~DATA
  KK677 28
  QQQJA 483
  32T3K 765
  T55J5 684
  KTJJT 220
DATA

input = File.read("2023/day_07/input.txt")
pp part_01(input)

# b = %w[32T3K KTJJT KK677 T55J5 QQQJA]

# (0..hands.size).each do |step|
#   puts "start: #{hands.map(&:cards).inspect}"
#   min_idx = step
#   puts "selection: #{hands[min_idx].cards}"
#
#   (step + 1..hands.size - 1).each do |i|
#     puts "comparing #{hands[i].cards} and #{hands[min_idx].cards}"
#     if ranked_less?(hands[i], hands[min_idx])
#       puts "#{hands[i].cards} are ranked less than #{hands[min_idx].cards}"
#       min_idx = i
#     else
#       puts "#{hands[i].cards} are ranked higher than #{hands[min_idx].cards}"
#     end
#   end
#
#   hands[step], hands[min_idx] = hands[min_idx], hands[step]
#   puts hands.map(&:cards).inspect
# end
# pp winnings.compact.filter(&:positive?).reduce(&:*)
# pp winnings.reduce(&:*)
# def ranked_less?(hand_a, hand_b)
#   return 0 if hand_a.cards == hand_b.cards
#
#   if hand_a.card_type_index < hand_b.card_type_index
#     -1
#   elsif hand_a.card_type_index == hand_b.card_type_index
#     hand_a.card_array.each_with_index do |card, idx|
#       if card_strength(card) < card_strength(hand_b.cards[idx])
#         return -1
#       elsif card_strength(card) > card_strength(hand_b.cards[idx])
#         return 1
#       end
#     end
#   else
#     1
#   end
# end
#

#
# 251545216
#
