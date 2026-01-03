require_relative '10_1'

module Day10_2
  
  include Day10_1

  extend self

  def joltages_to_lights(joltages)
    joltages.reverse.reduce(0) { |acc, joltage| acc * 2 + (joltage % 2) }
  end

  def halve_joltages(joltages)
    joltages.map { |joltage| joltage / 2 }
  end

  def minimum_presses((_, buttons, joltages_target))
    buttons_combo = ButtonCombo.new(buttons)

    cache = {}

    minimum_recursive = lambda do |joltages_target|
      return cache[joltages_target] if cache.key? joltages_target
      
      return 0 if joltages_target.all?(&:zero?)

      return Float::INFINITY if joltages_target.any?(&:negative?)

      lights_target = joltages_to_lights joltages_target
      
      button_options = buttons_combo.for_lights(lights_target)

      button_options += [[]] if joltages_target.all?(&:even?) # the option to just halve

      return Float::INFINITY if button_options.empty?
      
      button_options.map do |selection|
        reduced_joltages = Array.new joltages_target
        selection.each do |button|
          button.each do |joltage_index|
            reduced_joltages[joltage_index] -= 1
          end
        end
        reduced_joltages.map! { |joltage| joltage / 2 }

        selection.length + 2 * minimum_recursive.call(reduced_joltages)
      end
      .min
      .tap { |answer| cache[joltages_target] = answer }
    end

    minimum_recursive.call(joltages_target)

  end

end
