require 'journey'

describe Journey do
  let(:station) { double :station }
  let(:station2) { double :station2 }
  let(:my_journey) { Journey.new(station) }

  it 'have an entry station' do
    expect(my_journey.entry_station).to eq station
  end

  it 'has no exit station set by default' do
    expect(my_journey.exit_station).to eq nil
  end

  it 'the method sets an exit station' do
    my_journey.set_exit_station(station2)
    expect(my_journey.exit_station).to eq station2
  end

  it 'Can charge a penalty fare' do
    expect(my_journey.fare).to eq(Journey::PENALTY_FARE)
  end

  it 'can charge a minimum fare if stations given' do
    my_journey.set_exit_station(station2)
    expect(my_journey.fare).to eq(Journey::MIN_FARE)
  end
end
