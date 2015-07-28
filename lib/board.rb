require_relative './ship.rb'

class Board

  DEFAULT_SIZE = [2, 2]

  attr_reader :size, :ships

  def initialize(size = DEFAULT_SIZE)
    @size = DEFAULT_SIZE
    @ships = {}
  end

  def place_ship(ship, location, direction) 
    ships << ship
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