class Passenger < ApplicationRecord
  has_many :trips
  validates :phone_num, presence: true, uniqueness: true,
                numericality: { only_integer: true }, length: 10
  validates :name, presence: true
end
