require_relative '01_1'

module Day01_2
  include Day01_1

  def self.execute(input)
    deltas = input.each_line.map(&DELTAS)

    dial_position = 50
    counter = 0

    deltas.each do |delta|
      raw_dial_position = dial_position + delta
      turns, new_dial_position = raw_dial_position.divmod DIAL_SIZE
      counter += turns.abs
      if delta.negative? # special cases for left dial turn
        counter -= 1 if dial_position.zero? # fix overcount when starting from 0
        counter += 1 if new_dial_position.zero? # fix undercount when landing on 0
      end
      dial_position = new_dial_position
    end

    counter
  end

end

puts Day01_2.execute(ARGF) if $PROGRAM_NAME == __FILE__
