require_relative '08_1'

module Day08_2
  
  extend self

  include Day08_1

  def execute(input)
    nodes = parse_nodes(input.lines(chomp: true))

    edges = []

    (0...nodes.length - 1).each do |i|
      (i + 1...nodes.length).each do |j|
        edges << [i, j, d_squared(nodes[i], nodes[j])]
      end
    end

    sorted = edges.sort_by { |edge| edge[-1] }

    node_colors = Array.new(nodes.length) { _1 }
    unique_colors = node_colors.dup

    sorted.each do |i, j|
      next if node_colors[i] == node_colors[j]

      union_color, other_color = [node_colors[i], node_colors[j]].minmax
      unique_colors.delete(other_color)
      node_colors.map! do |color|
        color == other_color ? union_color : color 
      end

      return nodes[i].first * nodes[j].first if unique_colors.length == 1
    end
  end

end
