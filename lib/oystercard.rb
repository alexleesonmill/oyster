# frozen_string_literal: true

require_relative './journey'
require_relative './station'

class Oystercard
  attr_reader :balance, :journeys, :current_journey

  LIMIT = 90
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @current_journey = nil
    @journeys = []
  end

  def in_journey?
    !!@current_journey
  end

  def top_up(amount)
    raise "you have exeeded your max balance of £#{LIMIT}" if balance + amount > LIMIT

    @balance += amount
  end

  def touch_in(station)
    end_journey if @current_journey
    raise 'not enough balance' if balance < MIN_FARE

    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    @current_journey ? @current_journey.set_exit_station(station) : @current_journey = Journey.new(nil, station)
    end_journey
  end

  private

  def end_journey
    deduct(@current_journey.fare)
    save_journey
    @current_journey = nil
  end

  def deduct(amount)
    @balance -= amount
  end

  def save_journey
    @journeys << @current_journey
    @current_journey = nil
  end
end
