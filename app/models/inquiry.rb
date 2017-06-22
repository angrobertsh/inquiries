class Inquiry < ApplicationRecord
  after_initialize :set_price_and_taxes
  validates :user_id, :unit_id, :start_date, :end_date, presence: true
  validate :overlapping_inquiries

  belongs_to :user
  belongs_to :unit
  has_many :day_prices, through: :unit

  def set_price_and_taxes
    @day_prices = DayPrice.where('unit_id = ?', self.unit_id)
                            .where('date < ?', self.end_date)
                            .where('date >= ?', self.start_date)
    @day_prices = @day_prices.map{|day_price| day_price.price}.inject(:+)
    @unit = Unit.where('id = ?', self.unit_id)
    if @day_prices.nil?
      @day_prices = 0
    end
    self.total_price = @day_prices
    self.taxes_withheld = self.total_price * @unit.tax_percent
  end


  def reset_price_and_taxes!
    @day_prices = @day_prices.map{|day_price| day_price.price}.inject(:+)
    @unit = Unit.where('id = ?', self.unit_id)
    if @day_prices.nil?
      @day_prices = 0
    end
    self.total_price = @day_prices
    self.taxes_withheld = self.total_price * @unit.tax_percent
    self.save!
  end

  def self.overlapping(inquiry)
    if inquiry.id.nil?
      self.where("(start_date, end_date) OVERLAPS (?, ?)", inquiry.start_date, inquiry.end_date)
        .where("unit_id = ?", inquiry.unit_id)
    else
      self.where("(start_date, end_date) OVERLAPS (?, ?)", inquiry.start_date, inquiry.end_date)
        .where("unit_id = ?", inquiry.unit_id)
        .where("id != ?", inquiry.id)
    end
  end

  def overlapping?
    self.class.overlapping(self).count > 0
  end

  protected

  def overlapping_inquiries
    if overlapping?
      errors[:time] << "slot is already filled"
    end
  end

end
