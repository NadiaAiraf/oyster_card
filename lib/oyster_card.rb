class OysterCard
  DEFAULT_MAXIMUM = 90
  attr_reader :balance, :maximum_balance

  def initialize(maximum_balance = DEFAULT_MAXIMUM)
    @balance = 0
    @maximum_balance = maximum_balance
  end

  def top_up(value)
    fail "Exceeded maximum card balance is #{maximum_balance}" if exceeds_maximum?(value)
    @balance += value
  end

  # private

  def exceeds_maximum?(value)
    balance + value > maximum_balance
  end

end
