module Day12
  
  extend self

  def shapes_and_regions(input)
    *shapes, areas = input.split("\n\n")

    shapes.map! { |shape| shape.lines(chomp: true).drop(1) }

    areas = areas.lines.map! { |area| area.scan(/\d+/).map(&:to_i) }

    [shapes, areas]
  end

  def execute(input)
    shapes, regions = shapes_and_regions(input)

    # it's alwaus going to be 3x3, but let's generalize
    shape_box_height = shapes.map(&:length).max
    shape_box_width = shapes.map { |row| row.map(&:length).max }.max

    shapes_filled_count = shapes.map { |shape| shape.map { |row| row.count('#') }.sum }

    tally = {
      clearly_possible: 0,
      clearly_impossible: 0,
      ambiguous: 0
    }

    regions.each do |width, height, *counts|
      box_unit_width = width / shape_box_width
      box_unit_height = height / shape_box_height

      if box_unit_height * box_unit_width >= counts.sum
        tally[:clearly_possible] += 1
        next
      end

      if width * height < counts.zip(shapes_filled_count).map { |shape_amount, filled_cells| shape_amount * filled_cells }.sum
        tally[:clearly_impossible] += 1
        next
      end

      tally[:ambiguous] += 1  #  `all - (possible + impossible)` after the loop, but I like the symmetry 
    end

    p tally

    tally[:clearly_possible]
  end

end
