require_relative "tic-tac-toe"
require_relative "player"

def main
  #Declaracion de variables y objetos
  turno = "a" #variable para controlar de quien es el turno actual
  game = TicTacToe.new
  player1 = Player.new
  player2 = Player.new
  game.game_intro
  #En base a la eleccion de los jugadores se determina quien inicia el juego
  who_start_first_game = game.player_choose player1, player2
  #El primer turno es  directo puesto que sabemos quien inicia
  game.turn_capture who_start_first_game
  game.print_board
  puts turno
  turno = who_start_first_game === player1 ? "P2" : "P1"
  puts turno
  # Empezamos a alternar entre jugadores
  game_loop turno, game, player1, player2
end

def who_start
end

def gameover(game)
  if game.full_board?
    return true
  end
end

def game_loop(turno, game, player1, player2)
  loop do
    puts turno
    if turno == "P1"
      game.turn_capture player1
      game.print_board
      turno = "P2"
    elsif turno == "P2"
      game.turn_capture player2
      game.print_board
      turno = "P1"
    end
    break if gameover game
  end
end

main
