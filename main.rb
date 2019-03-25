require_relative "tic-tac-toe"
require_relative "player"

def main
  #Declaracion de variables y objetos
  turno = "a" #variable para controlar de quien es el turno actual
  game = TicTacToe.new
  player1 = Player.new
  player2 = Player.new
  game.game_intro()
  #En base a la eleccion de los jugadores se determina quien inicia el juego
  who_start_first_game = game.player_choose(player1, player2)
  #El primer turno es  directo puesto que sabemos quien inicia
  #t_temp = game.turn_capture(who_start_first_game)
  #game.insert_play_on_board(who_start_first_game, t_temp)
  #game.print_board()
  jugada(game, who_start_first_game)
  turno = who_start_first_game === player1 ? "P2" : "P1"
  # Empezamos a alternar entre jugadores
  game_loop(turno, game, player1, player2)
end

def who_start
end

def gameover(game)
  if game.full_board?()
    puts "GAME OVER"
    return true
  end
end

def game_loop(turno, game, player1, player2)
  loop do
    if turno == "P1"
      jugada(game, player1)
      turno = "P2"
    elsif turno == "P2"
      jugada(game, player2)
      turno = "P1"
    end
    break if gameover(game)
  end
end

def jugada(game, player)
  loop do
    jugada_valida = false
    turno = game.turn_capture(player)
    if game.insert_play_on_board(player, turno)
      jugada_valida = true
    else
      jugada_valida = false
    end
    break if jugada_valida
  end
  game.print_board()
end

main
