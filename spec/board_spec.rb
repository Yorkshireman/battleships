require 'board'

describe Board do

  let(:ship_with_location){ double :ship_with_location, location: "A1", :squares => [:A1, :A2] }
  let(:ship_with_location2){ double :ship_with_location2, location: "A1", :squares => [:B1, :A2] }

  it 'has a default size' do
  	expect(subject.size).to eq Board::DEFAULT_SIZE
  end

	describe '#place_ship' do
		it 'takes a ship' do
			expect(subject).to respond_to(:place_ship).with(1).argument
		end

		it 'places a ship on the board' do
			subject.place_ship(ship_with_location)
			expect(subject.ships.include?(ship_with_location)).to be true
		end

		it 'fails if any squares are already occupied by a ship' do 
			subject.place_ship(ship_with_location)
			expect{subject.place_ship(ship_with_location2)}.to raise_error "One or more squares already occupied"
		end
	end

	it 'has a fire method' do
		expect(subject).to respond_to :fire
	end

	describe '#fire' do
		it 'has a position as an argument' do
			expect(subject).to respond_to(:fire).with(1).argument
		end

		it "fails if a ship doesn't exist at that location" do
			subject.place_ship(ship_with_location)
			expect{ subject.fire("A2") }.to raise_error "Miss!"
		end

		it "returns 'HIT!' if a ship does exist at that location" do
			subject.place_ship(ship_with_location)
			expect(subject.fire("A1")).to eq "HIT!"
		end
	end

end