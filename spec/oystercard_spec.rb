require 'oystercard'

describe Oystercard do
  it { is_expected.to respond_to(:top_up).with(1).argument}

  describe '#balance' do

    it "shows balance on the card" do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do

    it "adds money to the card" do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises an error when the balance surpasses 90' do
      maximum_balance = Oystercard::MAX_BALANCE
      subject.top_up(subject.limit)
      expect {subject.top_up 1}.to raise_error "Maximum Balance of #{maximum_balance} Reached"
    end

  end

  describe '#deduct' do
      it { is_expected.to respond_to(:deduct).with(1).argument }

      it 'deducts the amount of money specified as the argument' do
        subject.top_up(10)
        expect{subject.deduct 5}.to change{ subject.balance }.by -5
      end

  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey)}
  end

  describe '#touch_in' do
    it 'changes in_journey to true when card is touched in' do
      subject.touch_in
      expect(subject.in_journey).to eq true
    end

    it 'raises an error when the card has insufficient funds' do
      expect { subject.touch_in }.to raise_error "Insufficient Funds"
    end

  end

  describe '#touch_out' do
    it 'changes in_journey to false when card is touched out' do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey).to eq false
    end
  end
end
