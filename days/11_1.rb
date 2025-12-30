module Day11_1

  extend self

  def links(input)
    input.each_line.to_h do |line|
      from, *to = line.scan(/\w+/)
      [from, to]
    end
  end

  def paths_hash(to, connections)
    hash = Hash.new { |hash, server| hash[server] = connections[server]&.sum { |next_hop| hash[next_hop] } || 0 }
    hash[to] = 1
    hash
  end

  def execute(input)
    connections = links(input)
    paths_to_out = paths_hash('out', connections)

    paths_to_out['you']
  end

end
