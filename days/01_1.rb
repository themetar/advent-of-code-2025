module Day01_1

  DIAL_SIZE = 100

  DELTAS = proc do |line|
    direction = line[0]
    delta = line[1..].to_i
    delta = -delta if direction == 'L'
    delta
  end

  def self.execute(input)
    dial_position = 50
    counter = 0

    input.each_line
         .map(&DELTAS)
         .each do |delta|
           dial_position += delta
           dial_position %= DIAL_SIZE
           counter += 1 if dial_position.zero?
         end

    counter
  end

end

puts Day01_1.execute(ARGF) if $PROGRAM_NAME == __FILE__
