class Oystercard

  attr_reader :balance, :limit, :in_journey

  MAX_BALANCE = 90
  
  def initialize
    @balance = 0
    @limit = MAX_BALANCE
    @in_journey = false
  end

  def top_up(money)
    fail "Maximum Balance of #{limit} Reached" if balance + money > limit
    self.balance += money
  end

  def deduct(money)
    self.balance -= money
  end

  private
  attr_writer :balance
end
