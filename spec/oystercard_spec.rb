require 'oystercard'

describe Oystercard do

  let(:station) {double (:station)}

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

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?)}
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in).with(1).argument }
    it 'changes in_journey to true when card is touched in' do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq true
    end

    it 'raises an error when the card has insufficient funds' do
      expect { subject.touch_in(station) }.to raise_error "Insufficient Funds"
    end

    it 'assigns the current station when touched in' do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

  end

  describe '#touch_out' do
    it 'changes in_journey to false when card is touched out' do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      subject.touch_out
      subject.in_journey?
      expect(subject.in_journey?).to eq false
    end

    it 'forgets the entry station when touched out' do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end

    it 'deducts minimum fare from card balance' do
      expect {subject.touch_out}.to change{ subject.balance}.by -Oystercard::MIN_FARE
    end
  end
end
