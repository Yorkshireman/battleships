require_relative './ship.rb'

class Board

  DEFAULT_SIZE = 9

  attr_reader :ships, :size

  def initialize(size = DEFAULT_SIZE)
    @ships = {}
    @size = check_size(size)
  end

  def check_size(size)
    unless size > 0 && size <= 9
      fail "Maximum board size is 9"
    end
    size
  end

  # Use a yield instead for the outside_board??
  def place_ship ship, coordinate, direction
    fail "Invalid direction - please choose :S or :E" unless valid_direction? direction
    squares = generate_squares(ship, coordinate, direction) 
    ships.store(ship, squares)
  end

  def valid_direction? direction
    valid_directions = [:S, :E]
    valid_directions.include? direction
  end

  def generate_squares ship, coordinate, direction
    starting_square = coordinate
    squares = [starting_square]

    if direction == :S
      x = 0
      (ship_size(ship.type) - 1).times do
        squares << (squares[x]).next
        x += 1
      end
    end


    if direction == :E
      x = 0
      (ship_size(ship.type) - 1).times do
        coordinate = (coordinate.to_s[0].next + coordinate.to_s[1]).to_sym
        squares << coordinate
        x += 1
      end

    end

    check_for_errors(squares)
    
    squares
  end

  def check_for_errors(squares)
    fail "Cannot place there - outside the board" if outside_board?(squares)
    fail "Cannot place ship there - one or more squares would overlap an existing ship" if overlap?(squares)
  end

  def invalid_square?(square)
    !build_grid.member?(square)
  end

  def outside_board?(squares)
    squares.any?{|square| invalid_square?(square)}
  end

  def overlap?(squares)
    squares.each do |square|
      return true if ships.values.any?{|coords| coords.include?(square)}
    end
    return false
  end

  def locate_ship ship
    ships[ship]
  end

  def ship_size type
    sizes = {patrol_boat: 2, destroyer: 3, submarine: 3, battleship: 4, aircraft_carrier: 5}
    sizes[type]
  end

  def build_grid
    grid = []
    letters = []

    letter = "A"
    self.size.times do
      letters << letter
      letter = letter.next
    end

    letters.each do |letter|
      x = 1
      self.size.times do 
        grid << ((letter + x.to_s).to_sym)
        x += 1
      end
    end

    grid
  end

end
