# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :entry_station, :journeys

  LIMIT = 90
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil # change
    @journeys = []
  end

  def in_journey?
    !!@entry_station # change
  end

  def top_up(amount)
    raise "you have exeeded your max balance of £#{LIMIT}" if balance + amount > LIMIT

    @balance += amount
  end

  def touch_in(station)
    raise 'not enough balance' if balance < MIN_FARE

    @entry_station = station # change
  end

  def touch_out(station)
    deduct(MIN_FARE) # change
    save_journey(station) # change
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def save_journey(exit_station) # change
    @journeys << { entry_station: entry_station, exit_station: exit_station }
    @entry_station = nil
  end
end
