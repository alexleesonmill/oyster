# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :in_journey

  LIMIT = 90
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def top_up(amount)
    raise "you have exeeded your max balance of £#{LIMIT}" if balance + amount > LIMIT

    @balance += amount
  end

  def touch_in
    raise 'not enough balance' if balance < MIN_FARE

    @in_journey = true
  end

  def touch_out
    # raise 'not in journey' if @in_journey == false
    deduct(MIN_FARE)
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
