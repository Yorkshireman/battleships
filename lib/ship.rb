class Ship
  attr_reader :location, :type, :size, :direction, :squares

  def initialize(type, location, direction)
    fail 'Invalid ship type' unless valid_ship_type?(type)
    fail 'Direction must be :N, :S, :E or :W' unless valid_direction?(direction)
    @location = location
    @direction = direction
    @type = type
    @size = ship_types[type]
    @squares = occupies_squares(type, location, direction)
  end

  # only written for east and west facing ships so far
  # needs refactoring down.
  # MOVE RESPONSIBILITY OF OCCUPIES_SQUARES TO BOARD CLASS
  # MAYBE CHANGE LOCATION TO STARTING_SQUARE
  def occupies_squares(type, location, direction)
    squares = []

    # pushes first square into squares
    squares << location.to_sym

    if direction == :E
    	x = location.split(//).first
    	y = (location.split(//))[1]
    	
    	(size - 1).times do 
    		x = next_x_coordinate(x)
    		coordinate_string = x + y.to_s  #separate out into a separate method
    		squares << coordinate_string.to_sym
    	end
    end

    if direction == :W 
      x = location.split(//).first
      y = (location.split(//))[1]

      (size - 1).times do 
        x = previous_x_coordinate(x)
        coordinate_string = x + y.to_s
        squares << coordinate_string.to_sym
      end
    end

    return squares
  end

  def next_x_coordinate(x_coordinate)
    x_coordinate.next
  end

  def previous_x_coordinate(x_coordinate)
    (x_coordinate.chr.ord - 1).chr
  end

  def ship_types
    {patrol_boat: 2, destroyer: 3, submarine: 3, battleship: 4, aircraft_carrier: 5}
  end

  def valid_ship_type?(type)
  	ship_types.has_key?(type)
  end

  def valid_direction?(direction)
  	[:N, :S, :E, :W].include? direction
  end

end
