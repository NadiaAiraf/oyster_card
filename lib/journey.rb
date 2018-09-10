class Journey
  attr_reader :fare, :end_point

  def initialize
    @start_point = nil
    @end_point = nil
    @fare = nil
  end

  def set_start(station)
    fail "start station is set" if @start_point
    @start_point = station
  end

  def set_end(station)
    fail "end point is set" if @end_point
    @end_point = station
  end

  def apply_penalty
    @fare = 5
  end

  def set_fare
    @fare = 2 + @end_point.zone + @start_point.zone
  end
end
