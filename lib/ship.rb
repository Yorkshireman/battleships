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

  def occupies_squares(type, location, direction)
    squares = []

    # pushes first square into squares
    squares << location.to_sym

    if direction == :E
    	x = location.split(//).first
    	y = (location.split(//))[1]
    	
    	(size - 1).times do 
    		y = y.next!
    		coordinate_string = x << y.to_s
    		squares << coordinate_string.to_sym
    	end
    end

    return squares
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
