module Day03_1
  
  extend self

  def jolts(input)
    input.each_line(chomp: true)
         .map(&:chars)
         .map { |line| line.map(&:to_i) }
  end

  def execute(input)
    jolts(input)
      .sum do |jolts|
        major_digit = jolts[0...-1].max
        minor_digit = jolts[jolts.index(major_digit) + 1..].max
        major_digit * 10 + minor_digit
      end
  end
end
