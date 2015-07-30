require_relative './ship.rb'

class Board

  attr_reader :ships

  def initialize
    @ships = {}
  end

  def place_ship ship, location, direction
    squares = occupies_squares(ship, location, direction)
    if outside_board?(squares)
      fail "Cannot place there - outside the board"
    else  
      ships.store(ship, squares)
    end
  end

  def occupies_squares ship, location, direction
    starting_square = location
    squares = [starting_square]

    if direction == :S
      x = 0
        ( ship_size(ship.type) - 1 ).times do
        squares << (squares[x]).next
        x += 1
      end
    end

    if direction == :E
      x = 0
        ( ship_size(ship.type) - 1 ).times do
        location = location.to_s
        first_char = location[0].next
        second_char = location[1]
        location = (first_char + second_char).to_sym
        squares << location
        x += 1
      end
    end
    
    squares
  end

  def outside_board?(squares)
    squares.each do |square|
      valid_squares = [:A1, :A2, :A3, :A4, :A5, :A6, :A7, :A8, :A9, :B1, :B2, :B3, :B4, :B5, :B6, :B7, :B8, :B9, :C1, :C2, :C3, :C4, :C5, :C6, :C7, :C8, :C9, :D1, :D2, :D3, :D4, :D5, :D6, :D6, :D7, :D8, :D9, :E1, :E2, :E3, :E4, :E5, :E6, :E7, :E8, :E9, :F1, :F2, :F3, :F4, :F5, :F6, :F7, :F8, :F9, :G1, :G2, :G3, :G4, :G5, :G6, :G7, :G8, :G9, :H1, :H2, :H3, :H4, :H5, :H6, :H7, :H8, :H9, :I1, :I2, :I3, :I4, :I5, :I6, :I7, :I8, :I9]
      unless valid_squares.include?(square)
        return true
      else
        return false
      end
    end
  end

  def locate_ship ship
    ships[ship]
  end

  def ship_size type
    sizes = {patrol_boat: 2, destroyer: 3, submarine: 3, battleship: 4, aircraft_carrier: 5}
    sizes[type]
  end
end
