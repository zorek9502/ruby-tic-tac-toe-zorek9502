require_relative "tic-tac-toe"
require_relative "player"

def main(t_size)
  #Declaracion de variables y objetos
  turno = "a" #variable para controlar de quien es el turno actual
  game = TicTacToe.new(t_size)
  player1 = Player.new
  player2 = Player.new
  #game.game_intro()
  #En base a la eleccion de los jugadores se determina quien inicia el juego
  #who_start_first_game = game.player_choose(player1, player2)
  #El primer turno es  directo puesto que sabemos quien inicia
  #t_temp = game.turn_capture(who_start_first_game)
  #game.insert_play_on_board(who_start_first_game, t_temp)
  #game.print_board()
  #jugada(game, who_start_first_game)
  #turno = who_start_first_game === player1 ? "P2" : "P1"
  # Empezamos a alternar entre jugadores
  #game_loop(turno, game, player1, player2)
  if game.play_again?.include?("s")
    puts "repeat game"
  else
  end
end

def who_start
end

def gameover(game)
  if game.full_board?() || game.match()
    puts "GAME OVER"
    return "draw"
  end
  if game.match()
    puts "TIC TAC TOE"
    return "win"
  end
end

def game_loop(turno, game, player1, player2)
  kind_gameover = ""
  loop do
    if turno == "P1"
      jugada(game, player1)
      turno = "P2"
    elsif turno == "P2"
      jugada(game, player2)
      turno = "P1"
    end
    kind_gameover = gameover(game)
    break if kind_gameover == "draw" || kind_gameover == "win"
  end
  return kind_gameover
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

puts "Hola, antes que nada de que tamaño quieres que sea el tablero? 3,4,5,..?"
t_size = gets.chomp
while t_size.to_i == 0 || t_size.to_i < 2
  puts "#{t_size} no es un numero o no se puede ese tamaño, intenta de nuevo"
  t_size = gets.chomp
end

##puts "No puede ser de 1, lo creare de 3x3"
main(t_size.to_i)
