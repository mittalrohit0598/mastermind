# frozen_string_literal: false

# module CheckCode
module CheckCode
  def check_code(guess, code)
    temp_guess = String.new(guess)
    temp_code = String.new(code)
    temp_guess, temp_code = check_correct(temp_code, temp_guess)
    temp_guess = check_partially_correct(temp_code, temp_guess)
    [temp_guess.count('c'), temp_guess.count('p')]
  end

  def check_correct(code, guess)
    4.times { |i| guess[i] = code[i] = 'c' if guess[i] == code[i] && guess[i].to_i != 0 }
    [code, guess]
  end

  def check_partially_correct(code, guess)
    4.times do |i|
      4.times { |j| guess[i] = code[j] = 'p' if guess[i] == code[j] && guess[i].to_i != 0 }
    end
    guess
  end
end

# module ValidCode
module ValidCode
  def valid_code?(code)
    code.split('').all? { |digit| digit.to_i <= 5 && digit.to_i >= 1 } && code.length == 4
  end
end

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

# class Computer
class Computer < Player
  include CheckCode

  attr_accessor :candidates
  def initialize(name)
    super
    @candidates = possible_candidates
  end

  def make_move(previous_guess, code)
    temp_code = String.new(code)
    candidates.each do |candidate|
      candidates.delete(candidate) if check_code(previous_guess, candidate) != check_code(previous_guess, temp_code)
    end
    candidates[0]
  end

  def set_code
    code = []
    4.times do
      code << rand(1..4)
    end
    code.join('')
  end

  private

  def possible_candidates
    candidates = []
    5.times do |a|
      5.times do |b|
        5.times do |c|
          5.times { |d| candidates << "#{a + 1}#{b + 1}#{c + 1}#{d + 1}" }
        end
      end
    end
    candidates
  end
end

# class Code
class Code
  attr_reader :code
  def initialize(code)
    @code = code
  end
end

# class Game
class Game
  include CheckCode
  include ValidCode

  attr_accessor :human, :computer, :code_setter, :code
  def initialize(human = Player.new('Human'), computer = Computer.new('Computer'))
    @human = human
    @computer = computer
    @code_setter = ''
    @code = Code.new(set_code)
  end

  def play
    win = false
    guess = '1122'
    12.times do |i|
      guess = human_move(i) if code_setter == 'g'
      guess = computer_move(guess, i) if code_setter == 'c'
      correct = move_feedback(guess)
      win = win?(correct)
      break if win == true
    end
    game_over_message if win == false
  end

  private

  def win?(correct)
    if correct == 4
      game_over_message(:win)
      return true
    end
    false
  end

  def computer_move(guess, guess_number)
    guess = computer.make_move(guess, code.code) unless guess_number.zero?
    puts "Computer's guess number #{guess_number + 1}(4 digits between 1 - 5) is #{guess}"
    guess
  end

  def human_move(guess_number)
    loop do
      puts "Make guess number #{guess_number + 1}(4 digits between 1 - 5):"
      guess = gets.chomp
      return guess if valid_code?(guess)

      puts 'Invalid input! Try again.'
    end
  end

  def move_feedback(guess)
    correct, partially_correct = check_code(guess, code.code)
    puts "There are #{correct} correct numbers in correct positions."
    puts "There are #{partially_correct} correct numbers in incorrect positions."
    puts
    correct
  end

  def set_code
    puts 'Do you want to be the creator or the guesser of the secret code(c or g)?'
    loop do
      self.code_setter = gets.chomp.downcase
      break if %w[c g].include?(code_setter)

      puts 'Invalid input! Try again.'
    end
    return computer.set_code if code_setter == 'g'

    human.set_code
  end

  def game_over_message(result = :lose)
    if result == :win
      puts 'Congratulations! You guessed the secret code.' if code_setter == 'g'
      puts 'Oops! The computer guessed the secret code. Better luck next time.' if code_setter == 'c'
    else
      puts 'You couldn\'t guess the code. Better luck next time.' if code_setter == 'g'
      puts 'Congratulations! The computer couldn\'t guess the secret code.' if code_setter == 'c'
    end
  end
end

game = Game.new
game.play
