module Day06_2
  
  extend self

  WHITESPACE = /^\s+$/

  def execute(input)
    lines = input.lines(chomp: true)

    operations = lines.last.each_char.reject(&WHITESPACE.method(:match?)).map(&:to_sym)

    number_groups = lines[0...-1].map(&:chars)
                .reduce { |acc, line_chars| acc.zip(line_chars).map(&:join) }
                .each_with_object([[]]) do |string, numbers|
                  if WHITESPACE.match? string
                    numbers << []
                  else
                    numbers.last << string.to_i
                  end
                end

    # p number_groups
    # p operations

    number_groups.zip(operations).sum { |numbers, operation| numbers.reduce(&operation) }
  end
end
