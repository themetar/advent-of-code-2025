module Day10_1

  extend self

  class ButtonCombo

    def for_lights(lights_target)
      cache[lights_target]
    end

    private

    attr_accessor :binary_to_button, :cache
    
    def initialize(buttons)
      self.binary_to_button = buttons.to_h do |button|
        [
          button.reduce(0) { |acc, wire| acc | (1 << wire) },
          button
        ]
      end

      self.cache = Hash.new do |hash, lights_target|
        hash[lights_target] = buttons_for_lights(lights_target).map { |selection| selection.map(&binary_to_button) }
      end
    end

    def all_combinations(array)
      (1..array.length).reduce([].each) { |all, n| all + array.combination(n) }
    end

    def buttons_for_lights(lights_target)
      all_combinations(binary_to_button.keys).filter do |selected_buttons|
        selected_buttons.reduce(&:^) == lights_target
      end
    end
  
  end

  def parse_machines(input)
    input.each_line.map do |line|
      lights_indicator, *buttons, joltages = line.split(' ')

      lights_indicator = lights_indicator.scan(/[.#]/).reverse.reduce(0) { |acc, light| acc * 2 + (light == '.' ? 0 : 1) }

      buttons.map! do |button|
        button.scan(/\d+/).map(&:to_i)
      end

      joltages = joltages.scan(/\d+/).map(&:to_i)

      [lights_indicator, buttons, joltages]
    end
  end

  def minimum_presses((lights_target, buttons))
    ButtonCombo.new(buttons).for_lights(lights_target)
      .map(&:length)
      .min
  end

  def execute(input)
    parse_machines(input).sum do |machine|
      minimum_presses(machine)
    end
  end

end
