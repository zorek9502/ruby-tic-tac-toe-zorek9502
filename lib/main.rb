require_relative "tic-tac-toe" #importacion del archivo tic-tac-toc.rb
require_relative "player" #player.rb

def main(t_size)
  #Declaracion de variables y objetos
  turno = "a" #variable para controlar de quien es el turno actual
  game = TicTacToe.new(t_size) # Creacion del juego con un tablero de tamaño n
  player1 = Player.new #Creacion del jugador 1
  player2 = Player.new #Creacion del jugador 2
  game.game_intro() #Introduccion al juego
  #En base a la eleccion de los jugadores se determina quien inicia el juego
  who_start_first_game = game.player_choose(player1, player2)
  #Se imprime el tablero
  game.print_board()
  #Primera jugada con el jugador correspondiente
  jugada(game, who_start_first_game)
  #Se alterna el turno dependiendo de que jugador inicio
  turno = who_start_first_game === player1 ? "P2" : "P1"
  # Empezamos el loop del juego mientras quieran jugar
  loop do
    #k_go => King GameOver
    k_go = game_loop(turno, game, player1, player2)
    if k_go == "win" #En caso de ser victoria
      winer = turno == "P1" ? player2 : player1 #Se obtiene el ganador en base como quedo el proximo en tirar
      puts "FELICIDADES #{winer.nombre} GANASTE EL JUEGO" #Imprime mensaje de felicidades
    elsif k_go == "draw" #En caso de empate
      turno = who_start_first_game === player1 ? "P2" : "P1" #El proximo jugador que empieza sera el segundo en el juego anterior
    end
    sleep 1 #Pausa de 1 segundo
    game.reset_board #Limpia el tablero
    break if game.play_again?.include?("n") #Condicion para preguntar si quieren volver a jugar
  end
end

#Metodo para saber el motivo del termino del juego
def gameover(game)
  if game.full_board?() #Si el tablero se lleno primero es que hubo un empate
    puts "GAME OVER"
    return "draw"
  end
  if game.match() #Si se tiene match de fichas
    puts "TIC TAC TOE"
    return "win"
  end
end

#Metodo ciclo del juego en base al turno se realiza la jugada el jugador correspondiente
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
    kind_gameover = gameover(game) #Se verifica si se finalizo el juego
    break if kind_gameover == "draw" || kind_gameover == "win" #En caso de tener respuesta se termina el ciclo del juego
  end
  return kind_gameover #Regresamos el motivo de termino del juego
end

#Metodo para realizar una jugada
def jugada(game, player)
  #Ciclo para que se quede realizando la jugada hasta que esta sea valida
  loop do
    jugada_valida = false #Bandera
    turno = game.turn_capture(player) #Se realiza la captura del turno del jugador
    if game.insert_play_on_board(player, turno) #Si la respuesta de que se pudo insertar la jugada en el tablero es positiva se vuelve valida de lo contrario no
      jugada_valida = true
    else
      jugada_valida = false
    end
    break if jugada_valida
  end
  game.print_board() #Imprime el tablero al final de cada jugada
end

#Se pide de que tamaño se desea el tablero
puts "Hola, antes que nada de que tamaño quieres que sea el tablero? 3,4,5,.. 26(Maximo)?"
t_size = gets.chomp
#Validacion para que ingrese un numero y que este este dentro de un rango del 2 al 26
#Se tiene como limite 26 porque son 26 las letras del abecedario que se usaron para el sistema de coordenadas A-Z sin contar ñ
while t_size.to_i == 0 || t_size.to_i < 2 && t_size.to_i > 26
  puts "#{t_size} no es un numero o no se puede ese tamaño, intenta de nuevo"
  t_size = gets.chomp
end

#Se manda a llamar a la funcion principal del juego con el tamaño del tablero
main(t_size.to_i)
