require 'board'

describe Board do

  let(:patrol_boat){ double :patrol_boat, type: :patrol_boat }
  let(:destroyer){ double :destroyer, type: :destroyer }

  it 'can have a ship' do
    subject.place_ship(patrol_boat, :B1, :S)
    expect(subject.ships).to include patrol_boat
  end

  it 'ships cannot be placed outside the board' do 
    expect{subject.place_ship(patrol_boat, :L13, :S)}.to raise_error "Cannot place there - outside the board"
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
end