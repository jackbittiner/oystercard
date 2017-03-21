require_relative 'station'
class Oystercard
  attr_reader :balance, :limit, :deduct, :entry_station
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @limit = MAX_BALANCE
    @entry_station = nil
  end

  def top_up(money)
    fail "Maximum Balance of #{limit} Reached" if balance + money > limit
    self.balance += money
  end


  def touch_in(station)
    fail "Insufficient Funds" if balance < MIN_FARE
    self.entry_station = station
  end

  def touch_out
    deduct(MIN_FARE)
    self.entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  attr_writer :balance, :entry_station

  def deduct(money)
    self.balance -= money
  end

end
