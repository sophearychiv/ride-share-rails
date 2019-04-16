class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true, length: 17
end
