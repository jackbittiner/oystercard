require 'oystercard'

describe Oystercard do

  let(:station) {double (:station)}
  let(:entry_station) {double (:station)}
  let(:exit_station) {double (:station)}
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

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
      message = "Max Balance of #{maximum_balance} Reached"
      expect {subject.top_up 1}.to raise_error message
    end

  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?)}
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in).with(1).argument }

    context 'when fare is loaded and touch in occurs' do
      before do
        subject.top_up(Oystercard::MIN_FARE)
        subject.touch_in(station)
      end

      it 'changes in_journey to true when card is touched in' do
        expect(subject.in_journey?).to eq true
      end

      it 'assigns the current station when touched in' do
        expect(subject.entry_station).to eq station
      end
    end

    it 'raises an error when the card has insufficient funds' do
      expect { subject.touch_in(station) }.to raise_error "Insufficient Funds"
    end

  end

  describe '#touch_out' do

    it { is_expected.to respond_to(:touch_out).with(1).argument}

    context 'when fare is loaded and touch in and out occur' do
      before do
        subject.top_up(Oystercard::MIN_FARE)
        subject.touch_in(station)
        subject.touch_out(station)
      end
      it 'changes in_journey to false when card is touched out' do
        subject.in_journey?
        expect(subject.in_journey?).to eq false
      end

      it 'forgets the entry station when touched out' do
        expect(subject.entry_station).to eq nil
      end
    end

    it 'deducts minimum fare from card balance' do
      expect {subject.touch_out(station)}.to change{ subject.balance}.by -Oystercard::MIN_FARE
    end

    it 'stores entry and exit stations as a hash in journeys' do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey
    end
  end

  describe '#journeys' do
    it 'should have an empty array called journeys' do
    expect(subject.journeys).to be_empty
    end
  end
end
