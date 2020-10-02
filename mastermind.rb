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
  attr_reader :code
  def initialize(code)
    @code = code
  end

  def check_code(guess)
    temp_code = String.new(code)
    4.times do |i|
      guess[i] = temp_code[i] = 'c' if guess[i] == temp_code[i] && guess[i].to_i != 0
    end
    4.times do |i|
      4.times do |j|
        guess[i] = temp_code[j] = 'p' if guess[i] == temp_code[j] && guess[i].to_i != 0
      end
    end
    [guess.count('c'), guess.count('p')]
  end
end

# class Game
class Game
  attr_accessor :human, :computer, :code_setter, :code
  def initialize(human = Player.new('Human'), computer = Computer.new('Computer'))
    @human = human
    @computer = computer
    @code_setter = ''
    @code = Code.new(set_code)
  end

  def play
    play_human if code_setter == 'g'
    play_computer if code_setter == 'c'
  end

  def play_computer
    win = false
    12.times do |i|
      guess = computer.set_code
      puts "Computer's guess number #{i + 1}(4 digits between 1 - 5) is #{guess}"
      correct, partially_correct = code.check_code(guess)
      puts "There are #{correct} correct numbers in correct positions."
      puts "There are #{partially_correct} correct numbers in incorrect positions."
      if correct == 4
        game_over_message(:win)
        win = true
        break
      end
      puts
    end
    game_over_message if win == false
  end

  def play_human
    win = false
    12.times do |i|
      guess = ''
      loop do
        puts "Make guess number #{i + 1}(4 digits between 1 - 5):"
        guess = gets.chomp
        break if valid_code?(guess)

        puts 'Invalid input! Try again.'
      end
      correct, partially_correct = code.check_code(guess)
      puts "There are #{correct} correct numbers in correct positions."
      puts "There are #{partially_correct} correct numbers in incorrect positions."
      if correct == 4
        game_over_message(:win)
        win = true
        break
      end
      puts
    end
    game_over_message if win == false
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

  def game_over_message(result = :lose)
    if result == :win
      puts 'Congratulations! You guessed the secret code.'
    else
      puts 'You couldn\'t guess the code. Better luck next time.'
    end
  end
end

game = Game.new
game.play
