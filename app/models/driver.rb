class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true, length: { in: 17..17 }

  def all_trips
    return all_trips = self.trips
  end

  def average_rating
    all_ratings = all_trips.map do |trip|
      trip.rating
    end
    return 0 if all_ratings.empty?
    return average_rating = (all_ratings.sum / all_ratings.length).to_i
  end

  def total_earnings
    gross_profit = all_trips.map do |trip|
      trip.cost
    end
    total_earning = (gross_profit.sum - 1.65) * 0.8
    return total_earning
  end

  def available_driver
    return available_driver = self.find_by(availability: true)
  end
end
