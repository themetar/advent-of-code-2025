module Day08_1
  
  extend self

  def parse_nodes(lines)
    lines.map { |coords| coords.split(',').map(&:to_i) }
  end

  def d_squared(point_a, point_b)
    point_a.zip(point_b).sum { |coord_a, coord_b| (coord_a - coord_b)**2 }
  end

  def execute(input, max_links)
    nodes = parse_nodes(input.lines(chomp: true))

    edges = []
    
    (0...nodes.length - 1).each do |i|
      (i + 1...nodes.length).each do |j|
        edges << [i, j, d_squared(nodes[i], nodes[j])] 
      end
    end

    top_shortest = edges.sort_by { |edge| edge[-1] }.take(max_links)

    colors = 1
    node_colors = {}

    top_shortest.each do |i, j|
      has_i = node_colors.has_key? i
      has_j = node_colors.has_key? j


      if has_i && has_j
        next if node_colors[i] == node_colors[j] 

        # both but with different colors
        j_color = node_colors[j]
        node_colors.each do |node_id, color|
          node_colors[node_id] = node_colors[i] if color == j_color
        end
      elsif has_i
        node_colors[j] = node_colors[i]
      elsif has_j
        node_colors[i] = node_colors[j]
      else
        node_colors[i] = node_colors[j] = colors
        colors += 1
      end
    end

    groups = Hash.new { |hash, key| hash[key] = [] }

    node_colors.each { |node_id, color| groups[color] << node_id }

    groups.map { |_, nodes| nodes.length }.max(3).reduce(&:*)
  end
end
