require_relative '03_1'

module Day03_2
  include Day03_1
  
  extend self

  def execute(input)
    jolts(input)
      .sum do |jolts|
        start_search_from = 0
        12.downto(1).map do |remaining_to_find|
          sub_jolts = jolts[start_search_from..-remaining_to_find]
          digit = sub_jolts.max
          start_search_from += sub_jolts.index(digit) + 1
          digit
        end
        .reduce(0) { |acc, digit| acc * 10 + digit }
      end
  end
end
