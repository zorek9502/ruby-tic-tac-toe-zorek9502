require "Matrix"

#Estructura del tablero
#   |   |
#---|---|---
#   |   |
#---|---|---
#   |   |

#Estructura de coordenadas de tablero
#    1   2   3
#a [   ,    ,  ]
#b [   ,    ,  ]
#c [   ,    ,  ]

class TicTacToe
  tablero = Matrix[[], [], []]
  attr_reader :cruz, :bola

  def initialize
    @cruz = "X"
    @bola = "O"
  end

  def game_menu
  end

  def turn_capture
    valid = false
    loop do
      puts "Ingresa coordenas y tu ficha, ej: A,3 o C,2"
      turno = gets.chomp.downcase.split(",") #Captura las coordenadas del jugador, elimina el salto de linea, cambia los caracteres a minusculas y los separa en un el arreglo turno
      valid = turn_valid? turno
      break if valid
      unless valid
        puts "Datos no validos, favor de ingresar unicamente los siguentes caracteres a,b,c,1,2 o 3"
      end
    end
  end

  def turn_valid?(turno)
    if turno.length < 2
      return false
    else
      #Validacion en caso de que ingrese primero la fila y despues la columna
      if turno[0] == "a" || turno[0] == "b" || turno[0] == "c"
        if turno[1] == "1" || turno[1] == "2" || turno[1] == "3"
          return true
        else
          return false
        end
      else
        #Validacion en caso de que ingrese primero la columna y despues la fila
        if turno[0] == "1" || turno[0] == "2" || turno[0] == "3"
          if turno[1] == "a" || turno[1] == "b" || turno[1] == "c"
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
end

game = TicTacToe.new

game.turn_capture
