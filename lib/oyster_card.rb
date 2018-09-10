require 'journey'

class OysterCard
  DEFAULT_MAXIMUM = 90
  DEFAULT_FARE = 1
  attr_reader :balance, :maximum_balance, :minimum_fare, :start_point, :journey_history, :in_journey

  def initialize(maximum_balance: DEFAULT_MAXIMUM,
                 minimum_fare: DEFAULT_FARE,
                 journey_record: Journey,
                 station_type: Station)
    @balance = 0
    @maximum_balance = maximum_balance
    @in_journey = nil
    @minimum_fare = minimum_fare
    @start_point = nil
    @journey_history = []
    @journey_record = journey_record
  end

  def top_up(value)
    fail "Exceeded maximum card balance. Maximum is #{maximum_balance}" if exceeds_maximum?(value)
    @balance += value
  end

  def touch_in(station)
    check_if_in_journey if @in_journey != nil
    fail "Balance too low, minimum fare: £#{minimum_fare}" if balance_too_low?
    @in_journey = @journey_record.new
    @in_journey.set_start(station)
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

  def balance_too_low?
    balance < minimum_fare
  end

  def deduct(value)
    @balance -= value
  end

  def store_journey
    @journey_history << @in_journey
    @in_journey = nil
  end

  def clear_start_point
    @start_point = nil
  end

  def check_if_in_journey
    if @in_journey.end_point == nil
      @in_journey.apply_penalty
      touch_out(station_type.new("Penalty fare", -1))
    end
  end
end
