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
    return average_rating = (all_ratings.sum / all_ratings.length).to_i
  end
end
