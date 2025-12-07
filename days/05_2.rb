require_relative '05_1'

module Day05_2

  include Day05_1

  extend self

  def execute(input)
    ranges, = ranges_and_ids(input)

    ranges = ranges.sort_by(&:begin)

    ranges.drop(1).each_with_object([ranges.first]) do |range, disjoint_ranges|
      latest = disjoint_ranges[-1]
      if latest.overlap? range
        disjoint_ranges[-1] = Range.new latest.begin, [latest.end, range.end].max
      else
        disjoint_ranges << range
      end
    end
    .sum(&:size)
  end

end
