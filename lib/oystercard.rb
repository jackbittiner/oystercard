class Oystercard

  attr_reader :balance, :limit
  MAX_BALANCE = 90
  def initialize
    @balance = 0
    @limit = MAX_BALANCE
  end

  def top_up(money)
    fail "Maximum Balance of #{limit} Reached" if balance + money > limit
    self.balance += money
  end

  def deduct(money)
  end

  private
  attr_writer :balance
end
