class Unit < ApplicationRecord
  has_many :day_prices, inverse_of: :unit
  has_many :inquiries

  def average_price
    '%.2f' % (DayPrice.where("unit_id = ?", self.id)
            .order(id: :desc)
            .limit(7)
            .map{|day_price| day_price.price}
            .inject(:+)/7)
  end

end
