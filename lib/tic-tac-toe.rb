require "Matrix"
require_relative "player"
#Estructura del tablero
#   |   |
#--- --- ---
#   |   |
#--- --- ---
#   |   |

#Estructura de coordenadas de tablero
#    1   2   3 ...
#a [   ,    ,  ]
#b [   ,    ,  ]
#c [   ,    ,  ]

class TicTacToe
  @tablero

  def initialize(n)
    @tablero = Matrix.build(n) { " " }
  end

  def game_intro
    print "*********************************************************************************************************************\n"
    print "*###################################################################################################################*\n"
    print "*#####          ####        ####       ####          ######   #######       ###          ###         ###       #####*\n"
    print "*#########  ###########  #######  #############  #########  ##  #####  ############  #######  #####  ###  ##########*\n"
    print "*#########  ###########  #######  #############  #######  ######  ###  ############  #######  #####  ###     #######*\n"
    print "*#########  ###########  #######  #############  #######          ###  ############  #######  #####  ###  ##########*\n"
    print "*#########  ########        ####       ########  #######  ######  ###       #######  #######         ###       #####*\n"
    print "*###################################################################################################################*\n"
    print "*********************************************************************************************************************\n\n"
    puts "Bienvenidos al juego"
    puts
    puts "Las reglas son muy sencillas"
    puts "1.- Hay 2 jugadores uno con la ficha X y otro con O."
    puts "2.- La primera vez que inicia el juego el jugador que elija la X comienza y se va alternando."
    puts "3.- El juego termina cuando uno de los 2 logre tener 3 de sus fichas en diagonal, horizontal o vertical"
    puts "4.- Cuando el juego termine y quieran jugar de nuevo, el jugador que perdio la partida anterior comienza"
    puts "5.- En caso de empate, el jugador que hizo el segundo segundo movimiento comienza."
    puts "Got it? right..."
    puts "A continuacion te muestro un tablero de 3x3, esta compuesto por coordenadas, letras en las filas y numeros en las columnas\n\n"
    puts
    print "   1   2   3\n"
    print "A    |   |   \n"
    print "  --- --- ---\n"
    print "B    |   |   \n"
    print "  --- --- ---\n"
    print "C    |   |   \n"
    puts
    puts "\nDeberas ingresar la posicion en la que deseas poner tu ficha separados por ','"
    puts "por ejemplo quieres poner X en A,3 y un O en B,2"
    puts
    print "   1   2   3\n"
    print "A    |   | X \n"
    print "  --- --- ---\n"
    print "B    | O |   \n"
    print "  --- --- ---\n"
    print "C    |   |   \n"
    puts
    puts "Ya que hablamos de fichas, porque no me dicen que ficha van a querer y su nombre?"
  end

  def player_choose(player1, player2)
    player_s = nil
    puts "Player 1 dame tu nombre"
    player1.nombre = gets.chomp
    puts "Hola #{player1.nombre}"
    sleep 1
    puts "Player 2 dame tu nombre"
    player2.nombre = gets.chomp
    puts "Hola #{player2.nombre}"
    sleep 1
    puts "Perfecto, #{player1.nombre} dime que ficha escojes? X o O"
    ficha = gets.chomp.downcase
    if ficha == "x"
      puts "Bien tu seras el primero en elegir"
      sleep 1
      puts "#{player2.nombre} tu ficha sera O"
      player1.ficha = "X"
      player2.ficha = "O"
      player_s = player1
    elsif ficha == "o"
      puts "Muy bien"
      sleep 1
      puts "#{player2.nombre} tu ficha sera X y seras el primero en elejir"
      player1.ficha = "O"
      player2.ficha = "X"
      player_s = player2
    else
      puts "m m m m m m"
      sleep 1
      puts "Creei que leyeron bien las reglas ¬_¬ solo se puede X o O"
      sleep 1
      puts "De castigo yo eligire por ustedes"
      sleep 1
      puts "#{player1.nombre} tu seras O y #{player2.nombre} sera X"
      player1.ficha = "O"
      player2.ficha = "X"
      player_s = player2
    end
    sleep 2
    system("cls")
    puts "Si les parece bien comenzemos el juego :)"
    return player_s
  end

  def play_again?
    puts "Les gustaria jugar de nuevo? s/n"
    resp = gets.chomp.downcase
  end

  def turn_capture(player)
    valid = false
    turno = []
    loop do
      puts "Dame las coordenadas de tu jugada #{player.nombre.capitalize}"
      turno = gets.chomp.downcase.split(",") #Captura las coordenadas del jugador, elimina el salto de linea, cambia los caracteres a minusculas y los separa en un el arreglo turno
      valid = turn_valid? turno
      break if valid
      unless valid
        puts "Mi estimado, eso no se puede :(, solo se puede ingresar los siguentes caracteres a,b,c para las filas y 1,2,3 para columnas"
      end
    end
    turno
  end

  def turn_valid?(turno)
    if turno.length < 2
      return false
    else
      #Validacion en caso de que ingrese primero la fila y despues la columna
      if ("a".."z").member?(turno[0])
        if ("1".."26").member?(turno[1])
          return true
        else
          return false
        end
      else
        #Validacion en caso de que ingrese primero la columna y despues la fila
        if ("1".."26").member?(turno[0])
          if ("a".."z").member?(turno[1])
            return true
          else
            return false
          end
        else
          return false
        end
      end
    end
  end

  #Funcion para verificar si se puede insertar el turno en el tablero yde ser asi lo inserta
  def insert_play_on_board(player, turno)
    row_pos = 0
    #Verifica si el primer caracter del turno es letra, si si se obtiene su equivalente en numero siendo a = 0 y z = 26
    if turno[0].to_i == 0
      ("a".."z").each_with_index do |letra, i|
        if turno[0] == letra
          row_pos = i
        end
      end
    else #Si el primer caracter no fue letra significa que es numero y se procede a obtener el equivalente de la letra
      ("a".."z").each_with_index do |letra, i|
        if turno[1] == letra
          row_pos = i
        end
      end
    end
    col_pos = (turno[0].to_i != 0 ? turno[0].to_i : turno[1].to_i) - 1
    #Se pregunta que amenos que el espacio donde se piensa colocar la ficha sea un lugar vacio se inserta si no se descarta
    unless @tablero.component(row_pos, col_pos) != " "
      @tablero.send(:[]=, row_pos, col_pos, player.ficha)
      return true
    else
      puts "Lo siento ese lugar esta ocupado krnal"
      return false
    end
  end

  #Funcion para pintar el tablero
  def print_board
    @tablero.row_vectors().each_with_index { |row, i|
      print "#{row.component(i)}\n"
    }
    #Imprime los numeros de las columnas
    (1..@tablero.row_vectors.size).each { |n|
      print "  #{n}  "
    }
    puts
    #Imprime las letras de las filas
    letras = ("A".."Z").to_a
    (0...@tablero.row_vectors.size).each do |i|
      print "#{letras[i]} "
      @tablero.row_vectors()[i].each do |fila|
        print " #{fila} | "
      end
      puts
      print " ----" * @tablero.row_count
      puts
    end
  end

  #Funcion que regresa true si existe un espacio en blanco o false si no se encontraron espacios en blanco
  def full_board?
    blank_space = false
    @tablero.each do |n|
      if n == " "
        blank_space = true
      end
    end
    blank_space ? false : true
  end

  #Funcion para limpiar el tablero de juego
  def reset_board
    @tablero = @tablero.map { |a| a = " " }
    puts "tablero reseteado #{@tablero}"
  end

  #Funcion para buscar match
  def match()
    array_rows = @tablero.row_vectors() #Obtiene un array con todas las filas del tablero
    array_cols = @tablero.column_vectors()  #Obtiene un array con todas las columnas del tablero
    diagonal1 = []
    diagonal2 = []
    diagonals = []
    #Obtiene la diagonal normal
    (0...@tablero.row_vectors.length).each do |i|
      diagonal1.push(@tablero.component(i, i))
    end
    #Obtiene la diagonal invertida
    (0...@tablero.row_vectors.length).each do |i|
      diagonal2.push(@tablero.component(i, @tablero.row_vectors.length - i - 1))
    end
    diagonals.push(diagonal1, diagonal2) #Los arrays de las diagonales se asignan a otro array

    #Se pregunta si existe algun match en filas o columnas o en las diagonales, si si regresa true
    if look_for_a_match(array_rows) || self.look_for_a_match(array_cols) || self.look_for_a_match(diagonals)
      return true
    else
      return false
    end
  end

  private

  #Funcion que se encarga de buscar un match en el arreglo que recibe
  def look_for_a_match(array)
    tree_match = false
    array.each do |x|
      (1...x.size).each do |i|
        if x[0] != x[i] || x[i] == " "
          return false
        end
      end
      return true
    end
  end
end
