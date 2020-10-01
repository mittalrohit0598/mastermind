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
  attr_accessor :player1, :player2, :code_setter, :code
  def initialize(player1 = Player.new('Human'), player2 = Computer.new('Computer'))
    @human = player1
    @computer = player2
    @code = set_code
  end

  def play
  end

  def move
  end

  def set_code
  end

  def valid_code?
  end

  def game_over_message
  end
end

game = Game.new
game.play