module Day09_1
  
  extend self

  def tile_coordinates(input)
    input.scan(/\d+/).map(&:to_i).each_slice(2)
  end

  def tiles_by_row(input)
    tile_coordinates(input)
      .group_by(&:last)
      .map { |y, coordinates| [y, coordinates.map!(&:first).sort!] }
      .sort_by(&:first)
  end

  def side(a, b)
    (a - b).abs + 1
  end

  def area(x_a, y_a, x_b, y_b)
    side(x_a, x_b) * side(y_a, y_b)
  end

  def execute(input)
    tiles_by_row(input).combination(2).map do |(y_a, (x_left_a, x_right_a)), (y_b, (x_left_b, x_right_b))|
      [
        area(x_left_a, y_a, x_right_b, y_b),
        area(x_right_a, y_a, x_left_b, y_b)
      ].max
    end
    .max
  end

end
