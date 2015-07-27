require 'ship'

describe Ship do

  before(:each) do
    @ship = Ship.new(:battleship, 'location', :N)
  end

  it 'can be created with a location' do
    expect(@ship.location).to be_a String
  end

  it 'can be created with a type' do
    expect(@ship.type).to be_a Symbol
  end

  it 'has a size' do 
    expect(@ship.size).to be_a Integer
  end

  it 'has a direction' do 
    expect(@ship.direction).to be_truthy
  end

  it "has a 'squares' array" do
    expect(@ship.squares).to be_a Array
  end

  it 'populates squares array on initialization' do 
    expect(@ship.squares.count).to_not eq 0
  end

  context "when a patrol boat is created at A1 facing East" do 
    it 'its squares array consists of :A1 and :A2 only' do 
      @patrol_boat_at_A1_facing_east = Ship.new(:patrol_boat, "A1", :E)
      expect(@patrol_boat_at_A1_facing_east.squares).to eq [:A1, :A2]
    end
  end

  describe "#valid_direction?" do 
    it 'fails if direction is not valid' do 
      expect{Ship.new(:battleship, 'A1', :invalid_direction)}.to raise_error "Direction must be :N, :S, :E or :W"
    end
  end

  it 'type must match one of the ship types' do
    expect { Ship.new('incorrect_type', 'A1', :N) }.to raise_error 'Invalid ship type'
  end

  describe '#ship_types' do
    it 'returns a hash of ship types; each has a name and a size' do
      expect(@ship.ship_types).to be_a Hash
    end
  end
end
