require_relative '../days/09_1'

module Day09_2

  include Day09_1
  
  extend self

  def touch?((a, b), (c, d))
    b == c || a == c || b == d || a == d
  end

  def extend?((a, b), (c, d))
    b == c || a == d
  end

  def execute(input)
    tiles_by_row = tiles_by_row(input)

    inside_segments = []

    insides = tiles_by_row.map do |(y, segment)|
      touches, not_touches = inside_segments.partition { |row_segment| touch?(row_segment, segment) }

      case touches.length
      when 0
        inside_segments = [*not_touches, segment].sort!
        [y, inside_segments]
      when 1
        # includes or excludes
        adjacent = touches.first
        if extend?(adjacent, segment)
          # includes to inner space
          merged = [adjacent, segment].sort!.then { |(a, _), (_, d)| [a, d] }
          inside_segments = [merged, *not_touches].sort!
          [y, inside_segments]
        else
          # excludes (exits) inner space
          merged = adjacent.zip(segment).find { |(a, b)| a != b }&.sort!
          inside_segments = [merged, *not_touches].sort!
          [y + 1, inside_segments]
        end
      when 2
        # three-way join
        touches.sort!
        merged = [touches.first.first, touches.last.last]
        inside_segments = [merged, *not_touches].sort!
        [y, inside_segments]
      end
    end

    tiles_by_row.combination(2).map do |(y_a, (x_left_a, x_right_a)), (y_b, (x_left_b, x_right_b))|
      options = [
        [x_left_a, x_left_b],
        [x_left_a, x_right_b],
        [x_right_a, x_right_b],
        [x_right_a, x_left_b]
      ]

      i = insides.bsearch_index { |(y, _)| y_a <= y }
      j = insides.bsearch_index { |(y, _)| y_b < y }
      overlapping = insides[i...j]

      options.filter! do |(x_a, x_b)|
        overlapping.all? do |(_, segments)|
          segments.any? { |segment| x_a.between?(*segment) && x_b.between?(*segment) }
        end
      end

      options.map { |(x_a, x_b)| area(x_a, y_a, x_b, y_b) }.max || 0
    end
    .max
  end

end
