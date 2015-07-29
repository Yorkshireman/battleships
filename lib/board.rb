require_relative './ship.rb'

class Board

  attr_reader :grid

  def initialize
    @grid = {}
  end

  def place_ship ship, location, direction
    squares = occupies_squares(ship, location, direction)
    grid.store(ship, squares)
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

    if direction == :N
      x = 0
        ( ship_size(ship.type) - 1 ).times do
        location = location.to_s
        first_char = location[0]
        second_char = (location[1].to_i - 1).to_s
        location = (first_char + second_char).to_sym
        squares << location
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

    if direction == :W
      x = 0
        ( ship_size(ship.type) - 1 ).times do
        location = location.to_s
        first_char = (location[0].ord - 1).chr
        second_char = location[1]
        location = (first_char + second_char).to_sym
        squares << location
        x += 1
      end
    end
    
    squares
  end

  def locate_ship ship
    grid[ship]
  end

  def ship_size type
    sizes = {patrol_boat: 2, destroyer: 3, submarine: 3, battleship: 4, aircraft_carrier: 5}
    sizes[type]
  end
end
