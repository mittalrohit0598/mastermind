# frozen_string_literal: true

# class Player
class Player
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

# class Computer
class Computer < Player
  def make_move
  end

  def set_code
    code = []
    4.times do
      code << rand(1..4)
    end
    code.join('')
  end
end

# class Code
class Code
  def initialize(code)
    @code = code
  end

  def check_code
  end
end

# class Game
class Game
  attr_accessor :human, :computer, :code_setter, :code
  def initialize(human = Player.new('Human'), computer = Computer.new('Computer'))
    @human = human
    @computer = computer
    @code_setter = ''
    @code = set_code
  end

  def play
  end

  def move
  end

  def set_code
    puts 'Do you want to be the creator or the guesser of the secret code(c or g)?'
    loop do
      self.code_setter = gets.chomp.downcase
      break if %w[c g].include?(code_setter)

      puts 'Invalid input! Try again.'
    end
    return computer.set_code if code_setter == 'g'

    puts 'Enter your secret code of size 4(digits 1-5 allowed): '
    code = ''
    loop do
      code = gets.chomp
      break if valid_code?(code)

      puts 'Invalid input! Try again.'
    end
    code
  end

  def valid_code?(code)
    code.split('').all? { |digit| digit.to_i <= 5 && digit.to_i >= 1 } && code.length == 4
  end

  def game_over_message
  end
end

game = Game.new
game.play
