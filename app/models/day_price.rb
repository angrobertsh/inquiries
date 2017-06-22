class DayPrice < ApplicationRecord
  belongs_to :unit, inverse_of: :day_prices
  has_many :inquiries, through: :unit
end
