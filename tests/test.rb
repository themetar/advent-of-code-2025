# Meta-test that generates a test class on demand.
# 
# It reads input data from `inputs/XX_Y(_tag?).txt` files, where XX_Y matches a day and puzzle part id pair,
# and checks for equality against the answers provided in the `answers` directory.
# 
# The puzzle id is expected as an argument on the command line. Then the appropriate source file is loaded (`require`d).
# A test class is generated that runs `::execute` form the loaded module on the provided data.

unless ARGV.length > 0
  puts 'Usage:'
  puts "ruby #{__FILE__} <puzzle identifier>"
  puts
  puts "e.g.: ruby #{__FILE__} 01_1"
  exit 1
end

puzzle_id = ARGV[0]

_, day, puzzle = *puzzle_id.match(/(..)_(.)/)

require "minitest/autorun"

require_relative "../days/#{puzzle_id}"

inputs_dir = Dir.new("inputs")

puzzle_inputs = inputs_dir.each_child.filter { |filename| /^#{day}(\.|_#{puzzle}|_[^\d])/.match? filename }

test_class = Class.new(Minitest::Test) do
  puzzle_inputs.each do |input_name|
    _, tag = * /^#{day}(?:_#{puzzle})?(.+).txt$/.match(input_name)

    define_method "test_#{puzzle}#{tag}" do
      input_path = File.join('inputs', input_name)
      answer_path = File.join('answers', "#{puzzle_id}#{tag}.txt")

      skip "No #{answer_path} file exists" unless File.exist? answer_path

      input = File.read input_path
      answer = File.read answer_path

      actual = Object.const_get("Day#{puzzle_id}").execute input

      assert_equal answer.chomp, actual.to_s
    end
  end
end

Object.const_set "Puzzle#{puzzle_id}Test", test_class
