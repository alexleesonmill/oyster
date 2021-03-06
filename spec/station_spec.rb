require 'station'

describe Station do
  let(:station) { Station.new(name: 'Brixton', zone: 1) }

  context 'Variables' do
    it 'knows its name' do
      expect(station.name).to eq('Brixton')
    end

    it 'knows its zone' do
      expect(station.zone).to eq(1)
    end
  end
end
