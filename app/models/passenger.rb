class Passenger < ApplicationRecord
  has_many :trips
  validates :phone_num, presence: true, uniqueness: true
  validates :name, presence: true

  def all_trips
    return all_trips = self.trips
  end

  def total_cost
    total_cost = 0.0
    all_trips.each do |trip|
      if trip.cost == nil
        trip.cost = 0
      else
        total_cost += trip.cost
      end
    end
    return total_cost / 100
  end
end
