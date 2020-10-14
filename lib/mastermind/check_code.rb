# frozen_string_literal: true

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
