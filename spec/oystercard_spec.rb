require 'oystercard'

describe Oystercard do
  let(:topped_up_card) { Oystercard.new(10) }
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
      limit = Oystercard::LIMIT
      subject.top_up(limit)
      expect { subject.top_up(1) }.to raise_error "you have exeeded your max balance of £#{limit}"
    end
  end

  context '#Deduct Money' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'can deduct money from the balance of the card' do
      expect { subject.deduct(5) }.to change { subject.balance }.by(-5)
    end
  end

  context '#Journey status' do
    it 'user will initlialize "not in journey"' do
      expect(subject).not_to be_in_journey
    end
  end

  context '#Touching in' do
    it { is_expected.to respond_to :touch_in }

    it 'changes return to in journey on touch in' do
      topped_up_card.touch_in
      expect(topped_up_card).to be_in_journey
    end

    it 'throws error if touching in without enough money' do
      expect { subject.touch_in }.to raise_error 'not enough balance'
    end
  end

  context '#Touching out' do
    it 'changes returns not in journey on touch out' do
      topped_up_card.touch_in
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
  end
end
