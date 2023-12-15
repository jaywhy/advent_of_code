class Sequence
  attr_accessor :label, :focal_length, :operation

  def initialize(label, operation, focal_length)
    @label = label
    @operation = operation
    @focal_length = focal_length
  end

  def hash = hashing(label)

  private

  def hashing(label)
    label.chars.reduce(0) do |current_value, char|
      ((current_value + char.ord) * 17) % 256
    end
  end
end

def part_1(input)
  sequences = input.gsub(/\n/, "").split(",")

  sequences.map do |seq|
    hashing(seq)
  end.sum
end

def part_2(input)
  sequences = input.gsub(/\n/, "").split(",").map do |seq|
    Sequence.new(*seq.scan(/^([^-=]+)([=-])(\d+)?/).flatten)
  end

  boxes = Hash.new { |h, k| h[k] = [] }

  sequences.each do |seq|
    case seq.operation
    when "-"
      boxes[seq.hash].delete_if { |s| s.label == seq.label }
    when "="
      idx = boxes[seq.hash].find_index { |s| s.label == seq.label }
      if idx
        boxes[seq.hash][idx] = seq
      else
        boxes[seq.hash] << seq
      end
    end
  end

  boxes.flat_map do |box_number, slots|
    slots.each_with_index.map do |slot, slot_number|
      (box_number + 1) * (slot_number + 1) * slot.focal_length.to_i
    end
  end.sum
end

def hashing(seq)
  seq.chars.reduce(0) do |current_value, char|
    ((current_value + char.ord) * 17) % 256
  end
end

input = File.read("2023/day_15/input.txt")
input_test = <<~DATA
  rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
DATA

p part_1(input)
p part_2(input)
