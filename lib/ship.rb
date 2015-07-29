class Ship

  attr_reader :type

  def initialize type
    @type = type
    raise "Invalid ship type" unless valid_type?(type)
  end

  def valid_type?(type)
    types =[:patrol_boat, :submarine, :battleship, :destroyer, :aircraft_carrier]
    types.any?{|i| i == type}
  end
end
