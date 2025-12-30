require_relative '11_1'

module Day11_2

  extend self

  include Day11_1

  VALID_ORDERINGS = [
    %w[svr dac fft out],
    %w[svr fft dac out]
  ]

  def execute(input)
    connections = links(input)

    VALID_ORDERINGS.sum do |ordering|
      ordering.each_cons(2)
        .map { |from, to| paths_hash(to, connections)[from] }
        .reduce(&:*)
    end
  end

end
