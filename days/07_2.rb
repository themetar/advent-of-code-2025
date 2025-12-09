module Day07_2
  
  extend self

  def execute(input)
    beams, *space = input.lines(chomp: true)

    paths = beams.each_char.map { |ch| ch == 'S' ? 1 : 0 }

    space.each do |row|
      row.each_char.with_index do |cell, i|
        (cell == '^' && paths[i] > 0).tap do |hit_splitter|
          paths[i - 1] += paths[i] if hit_splitter && i - 1 >= 0
          paths[i + 1] += paths[i] if hit_splitter && i + 1 < row.length
          paths[i] = 0 if hit_splitter
        end
      end
    end

    paths.sum
  end

end
