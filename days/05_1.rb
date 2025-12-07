module Day05_1

  extend self

  def ranges_and_ids(input)
    ranges = []
    ids = []

    array = ranges

    input.each_line(chomp: true) do |line|
      if line.empty?
        array = ids
        next
      end

      array << line
    end

    ranges.map! { |string| Range.new(*string.split('-').map(&:to_i)) }
    ids.map!(&:to_i)

    [ranges, ids]
  end

  def execute(input)
    ranges, ids = ranges_and_ids input

    ids.count { |id| ranges.any? { |range| range.include? id } }
  end

end
