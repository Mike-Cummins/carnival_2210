require 'date'
require './ride'
require './visitor'

class Carnival
  attr_reader :name,
              :rides,
              :duration

  def initialize(name, duration)
    @name = name
    @duration = duration
    @rides = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    top_ride = @rides.max_by do |ride|
      ride.ride_count
    end
    top_ride
  end

end