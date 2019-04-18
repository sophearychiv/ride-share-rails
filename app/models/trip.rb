class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :rating, numericality: { allow_nil: true, greater_than: 0, less_than: 6 }
end
