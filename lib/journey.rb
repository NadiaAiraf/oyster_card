class Journey
  attr_reader :fare

  def initialize
    @start_point = nil
    @end_point = nil
    @fare = nil
  end

  def set_start(station)
    fail "start station is set" unless @start_point
    @start_point = station
  end

  def set_end(station)
    fail "end point is set" unless @end_point
    @end_point = station
  end

  def apply_penalty
    @fare = 5
  end

  def set_fare(zone_start,zone_end)
    @fare = 2
  end
end
