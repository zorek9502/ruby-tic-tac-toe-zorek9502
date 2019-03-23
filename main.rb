require_relative "tic-tac-toe"
require_relative "player"

game = TicTacToe.new
player1 = Player.new
player1.ficha = "X"

game.game_intro
game.player_choose

#sgame.turn_capture player1
