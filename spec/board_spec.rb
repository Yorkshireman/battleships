require 'board'

describe Board do

  let(:patrol_boat){ double :patrol_boat, size: 2 }

  it 'has a default size' do
  	expect(subject.size).to eq Board::DEFAULT_SIZE
  end

  describe '#place_ship' do
    it 'places a ship on the board' do 
      subject.place_ship(patrol_boat, "A1", :E)
      expect(subject.ships).to have_key patrol_boat
    end

    it "stores a record of a ship's location on the board" do 
      subject.place_ship(patrol_boat, "A1", :E)
      expect(subject.ships[patrol_boat]).to eq [:A1, :B1]
    end
  end

  describe '#where_is_ship?' do 
    it 'returns an array of squares the ship occupies' do 
      expect(subject.where_is_ship?(patrol_boat, "A1", :E)).to eq [:A1, :B1]
    end
  end  

  # let(:ship_with_location){ double :ship_with_location, location: "A1", :squares => [:A1, :A2] }
  # let(:ship_with_location2){ double :ship_with_location2, location: "A1", :squares => [:B1, :A2] }

	# describe '#place_ship' do
	# 	it 'places a ship on the board' do
	# 		subject.place_ship(ship_with_location)
	# 		expect(subject.ships).to include (ship_with_location)
	# 	end

	# 	it 'fails if any squares are already occupied by a ship' do 
	# 		subject.place_ship(ship_with_location)
	# 		expect{subject.place_ship(ship_with_location2)}.to raise_error "One or more squares already occupied"
	# 	end
	# end

	# describe '#fire' do
	# 	it "fails if a ship doesn't exist at that location" do
	# 		subject.place_ship(ship_with_location)
	# 		expect(subject.fire "A2").to eq "Miss!" # Should be a method instead
	# 	end

	# 	it "returns 'HIT!' if a ship does exist at that location" do
	# 		subject.place_ship(ship_with_location)
	# 		expect(subject.fire("A1")).to eq "HIT!" # Should be a method instead
	# 	end
	# end

end