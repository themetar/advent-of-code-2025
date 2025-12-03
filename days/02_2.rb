# Brure force, check every number

require_relative '02_1'

module Day02_2

  include Day02_1

  extend self

  def segment(number, size: 1)
    length = number_length number
    number.div 10**(length - size)
  end

  def repeat(number, n: 1)
    length = number_length number
    n.times.reduce(0) { |acc| acc * 10**length + number }
  end

  def repeating?(number, segment_size)
    length = number_length number
    (length % segment_size).zero? && repeat(segment(number, size: segment_size), n: length / segment_size) == number
  end

  def execute(input)
    ranges(input).sum do |start, stop|
      (start..stop).sum do |candidate|
        length = number_length(candidate)
        next 0 unless (1..length/2).any? { |segment_size| repeating?(candidate, segment_size) }

        candidate
      end
    end
  end

end
