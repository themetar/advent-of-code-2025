module Day04_1

  extend self

  # row, column
  ADJACENT = [
    [-1, -1], [-1, 0], [-1, 1],
    [0,  -1],          [0,  1],
    [1,  -1], [1,  0], [1,  1]
  ]

  def paper_rolls(input)
    input.each_line(chomp: true).map(&:chars)
  end

  def adjacent_cells(row, col, height, width)
    return to_enum(:adjacent_cells, row, col, height, width) unless block_given?

    ADJACENT.each do |r, c|
      next unless (row + r).between?(0, height - 1) && (col + c).between?(0, width - 1)

      yield row + r, col + c
    end
  end

  def execute(input)
    paper_rolls = paper_rolls(input)
    height = paper_rolls.length
    width = paper_rolls.first.length

    paper_rolls.each_with_index.sum do |line, row|
      line.each_with_index.count do |item, col|
        next false unless item == '@'

        adjacent_cells(row, col, height, width)
          .map { |row, col| paper_rolls.dig(row, col) }
          .count('@') < 4
      end
    end
  end
end
