module Day06_1
  
  extend self

  def math_worksheet(input)
    input.each_line(chomp: true)
         .map(&:strip)
         .map { |line| line.split(/\s+/) }
         .transpose
  end

  def execute(input)
    worksheet = math_worksheet(input)

    worksheet.sum do |problem|
      operation = problem.last.to_sym
      problem[...-1].map(&:to_i).reduce(&operation)
    end
  end
end
