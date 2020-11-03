class Journey
  attr_reader :entry_station, :exit_station
  PENALTY_FARE = 6
  MIN_FARE = 1

  def initialize(entry_station, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def set_exit_station(exit_station)
    @exit_station = exit_station
  end

  def fare
    return PENALTY_FARE if penalty?

    MIN_FARE
  end

  private

  def penalty?
    !@entry_station || !@exit_station
  end
end
