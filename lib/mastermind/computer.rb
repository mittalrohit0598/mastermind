# frozen_string_literal: true

require_relative 'player'

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
