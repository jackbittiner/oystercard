require_relative 'station'
class Oystercard
  attr_reader :balance, :limit, :in_journey, :deduct, :entry_station
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @limit = MAX_BALANCE
    @in_journey = false
    @current_station
  end

  def top_up(money)
    fail "Maximum Balance of #{limit} Reached" if balance + money > limit
    self.balance += money
  end


  def touch_in(station)
    fail "Insufficient Funds" if balance < MIN_FARE
    self.in_journey = true
    self.entry_station = station
  end

  def touch_out
    self.in_journey = false
    deduct(MIN_FARE)
  end


  private

  attr_writer :balance, :in_journey, :entry_station

  def deduct(money)
    self.balance -= money
  end

end
