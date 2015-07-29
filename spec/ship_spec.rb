require 'ship'

describe Ship do
  subject(:ship) { Ship.new :battleship }

  # it 'is created with a location' do
  #   expect(ship.location).to eq 'location'
  # end

  it 'is created with a type' do
    expect(ship.type).to eq :battleship
  end

  it 'has a size' do 
    expect(ship.size).to eq 4
  end

  # it 'has a direction' do 
  #   expect(ship.direction).to eq :N
  # end

  # describe 'Testing for east facing ships:' do
  #   context "when a patrol boat (2 squares long) is created at A1 facing East" do 
  #     it 'its squares array consists of :A1 and :B1 only' do 
  #       ship = Ship.new(:patrol_boat, "A1", :E)
  #       expect(ship.squares).to eq [:A1, :B1]
  #     end
  #   end

  #   context "when a destroyer (3 squares long) is created at A1 facing East" do 
  #     it 'its squares array consists of :A1, :B1 and :C1 only' do 
  #       destroyer_at_A1_facing_east = Ship.new(:destroyer, "A1", :E)
  #       expect(destroyer_at_A1_facing_east.squares).to eq [:A1, :B1, :C1]
  #     end
  #   end
  # end

  # describe 'Testing for west facing ships' do 
  #   context "when a patrol boat (2 squares long) is created at B1 facing West" do 
  #     it 'its squares array consists of :B1 and :A1 only' do 
  #       patrol_boat_at_B1_facing_west = Ship.new(:patrol_boat, "B1", :W)
  #       expect(patrol_boat_at_B1_facing_west.squares).to eq [:B1, :A1]
  #     end
  #   end

  #   context "when a destroyer (3 squares long) is created at C1 facing West" do 
  #     it 'its squares array consists of :C1, :B1 and :A1 only' do 
  #       destroyer_at_C1_facing_west = Ship.new(:destroyer, "C1", :W)
  #       expect(destroyer_at_C1_facing_west.squares).to eq [:C1, :B1, :A1]
  #     end
  #   end
  # end

  # describe "#valid_direction?" do 
  #   # it 'fails if direction is not valid' do 
  #   #   expect{Ship.new(:battleship, 'A1', :invalid_direction)}.to raise_error "Direction must be :N, :S, :E or :W"
  #   # end

  #   context 'for valid directions' do
  #     it 'returns true' do
  #       [:N, :S, :E, :W].each do |direction|
  #         expect(ship.valid_direction?(direction)).to be true
  #       end
  #     end
  #   end
  #   context 'for invalid directions' do
  #     it 'returns false' do
  #       [:T, "B", 2, :G].each do |direction|
  #         expect(ship.valid_direction?(direction)).to be false
  #       end
  #     end
  #   end
  # end

  ship_with_invalid_type = Ship.new 'nonsense'
  types = [ :patrol_boat, :submarine, :battleship, :destroyer ]
  expect(types.any?{|type| type == ship_with_invalid_type.type}).to raise_error 'Invalid ship type'

  it 'type must match one of the ship types' do
    expect{Ship.new('incorrect_type')}.to raise_error 'Invalid ship type'
  end

# test the method instead to return valid stuff
 describe '#ship_types' do
    it 'returns a hash of ship types; each has a name and a size' do
      expect(ship.ship_types).to be_a Hash
    end
  end
end
