module Day07_1
  
  extend self

  def execute(input)
    beams, *space = input.lines(chomp: true)

    beams.tr!('S', '|')

    space.sum do |row|
      row.each_char.with_index.count do |cell, i|
        (cell == '^' && beams[i] == '|').tap do |hit_splitter|
          beams[i - 1] = '|' if hit_splitter && i - 1 >= 0
          beams[i] = '.' if hit_splitter
          beams[i + 1] = '|' if hit_splitter && i + 1 < row.length
        end
      end
    end
  end

end
