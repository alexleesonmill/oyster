# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  let(:topped_up_card) { Oystercard.new(10) }
  let(:station) { double :station }
  context '#balance' do
    it 'when created has a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  context '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance of the card' do
      expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end
  end

  context '#max limit' do
    it 'Raises error if top up is over limit' do
      expect { topped_up_card.top_up(81) }.to raise_error "you have exeeded your max balance of £#{Oystercard::LIMIT}"
    end
  end

  context '#Journey status' do
    it 'user will initlialize "not in journey"' do
      expect(subject).not_to be_in_journey
    end
  end

  context '#Touching in' do
    it { is_expected.to respond_to :touch_in }

    it 'stores the entry station of the journey' do
      topped_up_card.touch_in(station)
      expect(topped_up_card.entry_station).to eq station
    end

    it 'changes return to in journey on touch in' do
      topped_up_card.touch_in(station)
      expect(topped_up_card).to be_in_journey
    end

    it 'throws error if touching in without enough money' do
      expect { subject.touch_in(station) }.to raise_error 'not enough balance'
    end
  end

  context '#Touching out' do
    it 'changes returns not in journey on touch out' do
      topped_up_card.touch_in(station)
      topped_up_card.touch_out
      expect(topped_up_card).not_to be_in_journey
    end

    # it "touch_out changes card status to 'not in use'" do
    #   subject.instance_variable_set(:@in_journey, true)
    #   expect { subject.touch_out }.to change { subject.in_journey }.from(true).to(false)
    # end

    # it 'will raise an error if user touches out whilst not in journey' do
    #   expect { subject.touch_out }.to raise_error 'not in journey'
    # end

    it 'deducts the minimum fare on touch out' do
      expect { topped_up_card.touch_out }.to change { topped_up_card.balance }. by(-Oystercard::MIN_FARE)
    end
  end
end
