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

  describe 'Testing for east facing ships:' do
    context "when a patrol boat (2 squares long) is created at A1 facing East" do 
      it 'its squares array consists of :A1 and :B1 only' do 
        @patrol_boat_at_A1_facing_east = Ship.new(:patrol_boat, "A1", :E)
        expect(@patrol_boat_at_A1_facing_east.squares).to eq [:A1, :B1]
      end
    end

    context "when a destroyer (3 squares long) is created at A1 facing East" do 
      it 'its squares array consists of :A1, :B1 and :C1 only' do 
        @destroyer_at_A1_facing_east = Ship.new(:destroyer, "A1", :E)
        expect(@destroyer_at_A1_facing_east.squares).to eq [:A1, :B1, :C1]
      end
    end
  end

  describe 'Testing for west facing ships' do 
    context "when a patrol boat (2 squares long) is created at B1 facing West" do 
      it 'its squares array consists of :B1 and :A1 only' do 
        @patrol_boat_at_B1_facing_west = Ship.new(:patrol_boat, "B1", :W)
        expect(@patrol_boat_at_B1_facing_west.squares).to eq [:B1, :A1]
      end
    end

    context "when a destroyer (3 squares long) is created at C1 facing West" do 
      it 'its squares array consists of :C1, :B1 and :A1 only' do 
        @destroyer_at_C1_facing_west = Ship.new(:destroyer, "C1", :W)
        expect(@destroyer_at_C1_facing_west.squares).to eq [:C1, :B1, :A1]
      end
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
