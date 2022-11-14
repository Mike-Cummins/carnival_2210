require './visitor'

class Ride
  attr_reader :name,
              :min_height,
              :admission_fee,
              :excitement,
              :total_revenue,
              :rider_log

  def initialize(info)
    @name = info[:name]
    @min_height = info[:min_height]
    @admission_fee = info[:admission_fee]
    @excitement = info[:excitement]
    @total_revenue = 0
    @rider_log = Hash.new { |hash, key| hash[key] = 0 }
  end

  def board_rider(visitor)
    if visitor.preferences.include?(@excitement) && visitor.height >= min_height
      @rider_log[visitor] += 1 && visitor.spending_money -= admission_fee
      @total_revenue += admission_fee
    end
  end
end