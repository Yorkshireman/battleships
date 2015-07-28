require_relative './ship.rb'

class Board

  DEFAULT_SIZE = [2, 2]

  attr_reader :size, :ships

  def initialize(size = DEFAULT_SIZE)
    @size = DEFAULT_SIZE
    @ships = {}
  end

  def place_ship(ship, location, direction) 
    ships[ship] = where_is_ship?(ship, location, direction)
  end

  def where_is_ship?(ship, location, direction)
    squares = []
    squares << location.to_sym

    if direction == :E 
      x = location.split(//).first
      y = (location.split(//))[1]

      (ship.size - 1).times do 
        x = next_x_coordinate(x)
        coordinate_string = x + y
        squares << coordinate_string.to_sym
      end
    end

    return squares
  end

  def next_x_coordinate(x_coordinate)
    x_coordinate.next
  end

	# attr_reader :ships, :size, :occupied_squares
	# DEFAULT_SIZE = [2, 2]

	# def initialize(size = DEFAULT_SIZE)
	# 	@ships = []
	# 	@size = DEFAULT_SIZE
	# 	@occupied_squares = []
	# end

	# def place_ship(ship)
	# 	ship.squares.each do |square|
	# 		fail "One or more squares already occupied" if occupied_squares.include?(square)
	# 		occupied_squares << square
	# 	end

	# 	ships << ship
	# end

	# def fire(position)
	# 	if ships.any?{ |ship| ship.location == position }
	# 		return "HIT!"
	# 	else
	# 		return "Miss!"
	# 	end
	# end
end