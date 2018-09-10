class OysterCard
  DEFAULT_MAXIMUM = 90
  attr_reader :balance, :maximum_balance

  def initialize(maximum_balance = DEFAULT_MAXIMUM)
    @balance = 0
    @maximum_balance = maximum_balance
    @in_journey = false
  end

  def top_up(value)
    fail "Exceeded maximum card balance. Maximum is #{maximum_balance}" if exceeds_maximum?(value)
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  # private

  def exceeds_maximum?(value)
    balance + value > maximum_balance
  end

  def in_journey?
    @in_journey
  end
end
