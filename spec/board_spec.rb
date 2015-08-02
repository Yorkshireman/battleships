require 'board'

describe Board do

  let(:patrol_boat){ double :patrol_boat, type: :patrol_boat }
  let(:destroyer){ double :destroyer, type: :destroyer }

  it 'has a default size' do 
    expect(subject.size).to eq Board::DEFAULT_SIZE
  end

  it 'has a maximum size of 9' do
    expect{Board.new 10}.to raise_error "Maximum board size is 9"
  end

  describe '#build_grid' do 
    it 'builds an appropriately sized grid according to the passed-in size' do 
      subject = Board.new 9
      expect(subject.build_grid).to eq [:A1, :A2, :A3, :A4, :A5, :A6, :A7, :A8, :A9, :B1, :B2, :B3, :B4, :B5, :B6, :B7, :B8, :B9, :C1, :C2, :C3, :C4, :C5, :C6, :C7, :C8, :C9, :D1, :D2, :D3, :D4, :D5, :D6, :D7, :D8, :D9, :E1, :E2, :E3, :E4, :E5, :E6, :E7, :E8, :E9, :F1, :F2, :F3, :F4, :F5, :F6, :F7, :F8, :F9, :G1, :G2, :G3, :G4, :G5, :G6, :G7, :G8, :G9, :H1, :H2, :H3, :H4, :H5, :H6, :H7, :H8, :H9, :I1, :I2, :I3, :I4, :I5, :I6, :I7, :I8, :I9]
    end
  end

  it 'can have a ship' do
    subject.place_ship(patrol_boat, :B1, :S)
    expect(subject.ships).to include patrol_boat
  end

  describe '#valid_direction?' do 
    it "returns false if passed a direction that isn't :N, :S, :E or :W" do 
      expect(subject.valid_direction? :G).to be false
    end

    it "returns true for :N" do 
      expect(subject.valid_direction? :N).to be true
    end

    it "returns true for :S" do 
      expect(subject.valid_direction? :S).to be true
    end

    it "returns true for :E" do 
      expect(subject.valid_direction? :E).to be true
    end

    it "returns true for :S" do 
      expect(subject.valid_direction? :W).to be true
    end
  end

  it 'will not place a ship with an invalid direction' do 
    expect{subject.place_ship :patrol_boat, :F5, :C}.to raise_error "Invalid direction - please choose :S or :E"
  end

  describe '#generate_squares' do 
    it 'returns correct squares for a north-facing ship' do 
      expect(subject.generate_squares destroyer, :B3, :N).to eq [:B3, :B2, :B1]
    end

    it 'returns correct squares for a south-facing ship' do 
      expect(subject.generate_squares destroyer, :B2, :S).to eq [:B2, :B3, :B4]
    end

    it 'returns correct squares for a west-facing ship' do
      expect(subject.generate_squares destroyer, :C5, :W).to eq [:C5, :B5, :A5]
    end
  end

  it 'ships cannot be placed outside the board' do 
    expect{subject.place_ship(patrol_boat, :BB3, :S)}.to raise_error "Cannot place there - outside the board"
    expect{subject.place_ship(patrol_boat, :I9, :S)}.to raise_error "Cannot place there - outside the board"
    expect{subject.place_ship(patrol_boat, :I9, :E)}.to raise_error "Cannot place there - outside the board"
    expect{subject.place_ship(patrol_boat, :A9, :S)}.to raise_error "Cannot place there - outside the board"
    expect{subject.place_ship(patrol_boat, :I1, :E)}.to raise_error "Cannot place there - outside the board"
  end

  describe '#outside_board?' do 
    it 'returns false when passed valid squares' do 
      valid_squares = [:A1, :A2, :A3, :A4, :A5, :A6, :A7, :A8, :A9, :B1, :B2, :B3, :B4, :B5, :B6, :B7, :B8, :B9, :C1, :C2, :C3, :C4, :C5, :C6, :C7, :C8, :C9, :D1, :D2, :D3, :D4, :D5, :D6, :D6, :D7, :D8, :D9, :E1, :E2, :E3, :E4, :E5, :E6, :E7, :E8, :E9, :F1, :F2, :F3, :F4, :F5, :F6, :F7, :F8, :F9, :G1, :G2, :G3, :G4, :G5, :G6, :G7, :G8, :G9, :H1, :H2, :H3, :H4, :H5, :H6, :H7, :H8, :H9, :I1, :I2, :I3, :I4, :I5, :I6, :I7, :I8, :I9]
      expect(subject.outside_board? valid_squares).to be false
    end

    it 'returns true when passed a mixture of valid and invalid squares' do 
      expect(subject.outside_board? [:J3, :A11, :A3]).to be true
    end
  end

  it 'ships cannot be placed overlapping an existing ship' do 
    subject.place_ship patrol_boat, :D4, :S
    expect{subject.place_ship destroyer, :B4, :E}.to raise_error "Cannot place ship there - one or more squares would overlap an existing ship"
  end

  describe '#overlap?' do 
    it 'returns true when a ship is placed on top of another ship' do 
      subject.place_ship patrol_boat, :D4, :E
      expect(subject.overlap? [:D2, :D3, :D4]).to be true
    end

    it 'returns false when a ship is placed that does not overlap another ship' do 
      subject.place_ship patrol_boat, :D4, :E 
      expect(subject.overlap? [:C1, :E1, :F1, :G1, :H1]).to be false
    end
  end

  describe '#locate_ship' do
    context 'after placing a destroyer facing south' do
      it 'returns the correct three squares' do
        subject.place_ship(destroyer, :D5, :S)
        expect(subject.locate_ship(destroyer)).to eq [:D5, :D6, :D7]
      end
    end

    context 'after placing a destroyer facing east' do
      it 'returns the correct three squares' do
        subject.place_ship(destroyer, :A1, :E)
        expect(subject.locate_ship(destroyer)).to eq [:A1, :B1, :C1]
      end
    end
  end

  describe '#hit?' do
    it 'if passed a square that contains a ship, it returns that ship' do 
      subject.place_ship destroyer, :D5, :W
      expect(subject.hit? :C5).to be true
    end

    it 'returns false if a passed a square that does not contain a ship' do 
      subject.place_ship destroyer, :C5, :S 
      expect(subject.hit? :D2).to be false
    end
  end

  describe '#fire_on' do 
    it "returns 'HIT!' if passed a square that contains a ship" do 
      subject.place_ship destroyer, :D5, :W
      expect(subject.fire_on :C5).to eq "HIT!!"
    end

    it "removes that square from the hit ship's coordinates array" do 
      subject.place_ship destroyer, :D5, :W
      subject.fire_on :C5
      expect(subject.ships[destroyer]).not_to include :C5
    end

    it "removes the relevant square from a ship's array (in the ships hash) if hit" do
      subject.place_ship destroyer, :D4, :S
      subject.fire_on :D5
      expect(subject.ships[destroyer]).not_to include :D5
    end

    describe '#remove_coordinate_from_ship' do 
      context "when passed an array of squares and a square as a second argument (that is also equal to a square in the array)" do
        it 'finds the index of the matching square and removes that square from the array' do 
          coordinates = [:A1, :A2, :A3, :A4]
          subject.remove_coordinate_from_ship coordinates, :A2
          expect(coordinates).to_not include :A2
        end
      end
    end

    it "returns 'MISS!!!' if passed a square that does not contain a ship" do
      subject.place_ship destroyer, :D5, :W
      expect(subject.fire_on :C3).to eq "MISS!"
    end
  end

end