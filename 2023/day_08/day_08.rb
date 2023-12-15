def part_1(input)
  instructions, network = parse_network(input)
  pp find_steps(instructions, network, "AAA")
end

def part_2(input)
  instructions, network = parse_network(input)

  starting_nodes = network.select { |node| node =~ /A$/ }.keys
  node_steps = starting_nodes.map do |node|
    p "node: #{node}"
    steps = find_steps(instructions, network, node)
    p steps
    steps
  end

  pp node_steps
  pp node_steps.reduce(1, :lcm)
end

def find_steps(instructions, network, node)
  steps = 0

  until node.end_with?("Z")
    instructions.each do |instruction|
      steps += 1
      node = if instruction == "L"
               network[node][0]
             else
               network[node][1]
             end
    end
  end

  steps
end

def parse_network(input)
  instructions, nodes = input.split("\n\n")
  instructions = instructions.split("")
  network = nodes
            .split("\n")
            .map { |node| node.split(" = ") }
            .to_h
            .transform_values do |directions|
    directions.scan(/\((\w+), (\w+)\)/).flatten
  end

  [instructions, network]
end

input_test = <<~DATA
  RL

  AAA = (BBB, CCC)
  BBB = (DDD, EEE)
  CCC = (ZZZ, GGG)
  DDD = (DDD, DDD)
  EEE = (EEE, EEE)
  GGG = (GGG, GGG)
  ZZZ = (ZZZ, ZZZ)
DATA

input = File.read("2023/day_08/input.txt")

# part_1(input)
part_2(input)