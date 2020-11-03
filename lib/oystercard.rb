# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :entry_station

  LIMIT = 90
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
  end

  def in_journey?
    @entry_station ? true : false
  end

  def top_up(amount)
    raise "you have exeeded your max balance of £#{LIMIT}" if balance + amount > LIMIT

    @balance += amount
  end

  def touch_in(station)
    raise 'not enough balance' if balance < MIN_FARE

    @entry_station = station
  end

  def touch_out
    # raise 'not in journey' if @in_journey == false
    deduct(MIN_FARE)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
