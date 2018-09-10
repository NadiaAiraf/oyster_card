require 'journey'

class OysterCard
  DEFAULT_MAXIMUM = 90
  DEFAULT_FARE = 1
  attr_reader :balance, :maximum_balance, :minimum_fare, :start_point, :journey_history

  def initialize(maximum_balance = DEFAULT_MAXIMUM,
                 minimum_fare = DEFAULT_FARE)
    @balance = 0
    @maximum_balance = maximum_balance
    @in_journey = nil
    @minimum_fare = minimum_fare
    @start_point = nil
    @journey_history = []
  end

  def top_up(value)
    fail "Exceeded maximum card balance. Maximum is #{maximum_balance}" if exceeds_maximum?(value)
    @balance += value
  end

  def touch_in(station)
    check_if_in_journey
    fail "Balance too low, minimum fare: £#{minimum_fare}" if balance_too_low?
    @in_journey = Journey.new.set_start(station)
  end

  def touch_out(station)
    @in_journey.set_end(station)
    deduct(@in_journey.fare)
    store_journey
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

  def store_journey(station)
    @journey_history << @in_journey
    @in_journey = nil
  end

  def clear_start_point
    @start_point = nil
  end

  def check_if_in_journey

  end
end
