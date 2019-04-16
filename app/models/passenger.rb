class Passenger < ApplicationRecord
  has_many :trips
  validates :phone_num, presence: true, uniqueness: true
  validates :name, presence: true
end
