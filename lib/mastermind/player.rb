# frozen_string_literal: true

# class Player
class Player
  include ValidCode

  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def set_code
    puts 'Enter your secret code of size 4(digits 1 - 5 allowed): '
    code = ''
    loop do
      code = gets.chomp
      return code if valid_code?(code)

      puts 'Invalid input! Try again.'
    end
  end
end
