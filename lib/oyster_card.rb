class OysterCard
  DEFAULT_MAXIMUM = 90
  DEFAULT_FARE = 1
  attr_reader :balance, :maximum_balance, :minimum_fare

  def initialize(maximum_balance = DEFAULT_MAXIMUM,
                 minimum_fare = DEFAULT_FARE)
    @balance = 0
    @maximum_balance = maximum_balance
    @in_journey = false
    @minimum_fare = minimum_fare
  end

  def top_up(value)
    fail "Exceeded maximum card balance. Maximum is #{maximum_balance}" if exceeds_maximum?(value)
    @balance += value
  end


  def touch_in
    fail "Balance too low, minimum fare: £#{minimum_fare}" if balance_too_low?
    @in_journey = true
  end

  def touch_out
    deduct(minimum_fare)
    @in_journey = false
  end

  private

  def exceeds_maximum?(value)
    balance + value > maximum_balance
  end

  def in_journey?
    @in_journey
  end

  def balance_too_low?
    balance < minimum_fare
  end

  def deduct(value)
    @balance -= value
  end
  
end
