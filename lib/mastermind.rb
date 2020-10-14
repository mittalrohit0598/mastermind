# frozen_string_literal: true

require_relative 'mastermind/check_code'
require_relative 'mastermind/code'
require_relative 'mastermind/valid_code'
require_relative 'mastermind/computer'
require_relative 'mastermind/game'
require_relative 'mastermind/player'

game = Game.new
game.play
