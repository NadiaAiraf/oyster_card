require './journey'

class JourneyLog
  attr_reader :journey, :current_journey

  def initialize(journey: Journey)
    @current_journey = nil
    @journeys = []
    @journey = journey
  end

  def start(station)
    @current_journey = @journey.new
    @current_journey.set_start(station)
  end

  def finish(station)
    @current_journey.set_end(station)
  end

  def store_journey
    @journeys << @current_journey
    @current_journey = nil
  end

  def journeys
    @journeys
  end
end
