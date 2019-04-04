require "minitest/autorun"
require_relative "../lib/tic-tac-toe" #importacion del archivo tic-tac-toc.rb
require_relative "../lib/player"

class TicTacToe_test < Minitest::Test
  BOARD_SIZE = 3

  def setup
    @game = TicTacToe.new(BOARD_SIZE)
    @player = Player.new
    @player.ficha = "x"
    @player.nombre = "Testing"
  end

  #Prueba para validar un turno donde el primer elemento es una letra
  def test_turn_valid?
    turno = ["a", "2"]
    resp = @game.turn_valid?(turno)
    assert_equal(resp, true)
  end

  #Prueba para validar un turno donde el primer elemento es una letra y esta fuera del rango permitido
  def test_turn_valid_2?
    turno = ["f", "2"]
    resp = @game.turn_valid?(turno)
    assert_equal(resp, false)
  end

  #Prueba para validar un turno donde el primer elemento es un numero
  def test_turn_valid_2?
    turno = ["2", "c"]
    resp = @game.turn_valid?(turno)
    assert_equal(resp, true)
  end

  #Prueba para validar que se puede insertar un turno donde el primer elemento es un numero
  def test_insert_play_on_board
    turno = ["2", "a"]
    resp = @game.insert_play_on_board(@player, turno)
    assert_equal(resp, true)
  end

  #Prueba para validar que se puede insertar un turno donde el primer elemento es una letra
  def test_insert_play_on_board_2
    turno = ["b", "3"]
    resp = @game.insert_play_on_board(@player, turno)
    assert_equal(resp, true)
  end
end
