require 'board'

describe Board do

  let(:patrol_boat){ double :patrol_boat, type: :patrol_boat }
  let(:destroyer){ double :destroyer, type: :destroyer }

  it 'can have a ship' do
    subject.place_ship(patrol_boat, :B1, :S)
    expect(subject.grid).to include patrol_boat
  end

  describe '#locate_ship?' do

    context 'after placing a destroyer facing south' do
      it 'returns the correct three squares' do
        subject.place_ship(destroyer, :D5, :S)
        expect(subject.locate_ship(destroyer)).to eq [:D5, :D6, :D7]
      end
    end

    context 'after placing a destroyer facing north' do
      it 'returns the correct three squares' do
        subject.place_ship(destroyer, :D5, :N)
        expect(subject.locate_ship(destroyer)).to eq [:D5, :D4, :D3]
      end
    end

    context 'after placing a destroyer facing east' do
      it 'returns the correct three squares' do
        subject.place_ship(destroyer, :A1, :E)
        expect(subject.locate_ship(destroyer)).to eq [:A1, :B1, :C1]
      end
    end

    context 'after placing a destroyer facing west' do
      it 'returns the correct three squares' do
        subject.place_ship(destroyer, :C3, :W)
        expect(subject.locate_ship(destroyer)).to eq [:C3, :B3, :A3]
      end
    end

  end
end