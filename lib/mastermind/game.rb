# frozen_string_literal: true

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
