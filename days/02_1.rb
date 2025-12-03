module Day02_1

  extend self

  def number_length(number)
    Math.log10(number).floor + 1
  end

  def adjust_number(number, direction: :up)
    length = number_length number
    return number if length.even?

    direction == :up ? 10**length : 10**(length - 1) - 1
  end

  def high_half(number)
    length = number_length number
    number.div 10**(length/2)
  end

  def repeat(number)
    number * 10**number_length(number) + number
  end

  def ranges(input)
    input.scan(/\d+/)
         .map(&:to_i)
         .each_slice(2)
  end

  def execute(input)
    ranges(input).sum do |start, stop|
      even_left = adjust_number(start)
      next 0 unless even_left.between? start, stop

      even_right = adjust_number(stop, direction: :down)
      next 0 unless even_right.between? start, stop

      high_left = high_half even_left
      high_left += 1 if repeat(high_left) < start

      high_right = high_half even_right
      high_right -= 1 if repeat(high_right) > stop

      next 0 unless repeat(high_left).between?(start, stop) && repeat(high_right).between?(start, stop)

      (high_left..high_right).sum(&method(:repeat))
    end
  end

end

