require "minitest/autorun"
require_relative '../days/08_1'

class Puzzle08Test < Minitest::Test

  def test_1_example
    input_path = File.join('inputs', '08_example.txt')
    answer_path = File.join('answers', '08_1_example.txt')

    input = File.read input_path
    answer = File.read answer_path

    actual = Day08_1.execute(input, 10)

    assert_equal answer.chomp, actual.to_s
  end

  def test_1
    input_path = File.join('inputs', '08.txt')
    answer_path = File.join('answers', '08_1.txt')

    input = File.read input_path
    answer = File.read answer_path

    actual = Day08_1.execute(input, 1000)

    assert_equal answer.chomp, actual.to_s
  end

end
