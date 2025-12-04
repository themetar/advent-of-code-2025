require_relative '04_1'

module Day04_2
  
  include Day04_1

  extend self

  def execute(input)
    paper_rolls = paper_rolls(input)
    height = paper_rolls.length
    width = paper_rolls.first.length

    accumulator = 0

    loop do
      remove_count = (0...height).sum do |row|
        (0...width).count do |col|
          item = paper_rolls.dig(row, col)
          next false unless item == '@'

          adjacent_cells(row, col, height, width)
            .count { |row, col| paper_rolls.dig(row, col) == '@' }
            .then { |adjacent_rolls_count| adjacent_rolls_count < 4 }
            .tap { |should_remove| paper_rolls[row][col] = '.' if should_remove }
        end
      end
      break if remove_count.zero?
      accumulator += remove_count
    end

    accumulator
  end

end
