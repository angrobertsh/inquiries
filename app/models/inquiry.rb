class Inquiry < ApplicationRecord
  after_initialize :set_price_and_taxes
  validates :user_id, :unit_id, :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  validate :overlapping_inquiries

  belongs_to :user
  belongs_to :unit
  has_many :day_prices, through: :unit

  before_validation :set_price_and_taxes, if: -> { start_date.present? && end_date.present? && day_prices.present? }

  def day_prices
    return unless self.unit
    self.unit.day_prices.where(date: start_date...end_date)
  end

  def set_price_and_taxes
    return unless self.unit && self.day_prices.present?
    self.total_price = self.day_prices.map{|day_price| day_price.price}.inject(:+)
    if self.total_price.nil?
      self.total_price = 0
    end
    self.taxes_withheld = self.total_price * self.unit.tax_percent
  end


  def reset_price_and_taxes!
    self.total_price = self.day_prices.map{|day_price| day_price.price}.inject(:+)
    if self.total_price.nil?
      self.total_price = 0
    end
    self.taxes_withheld = self.total_price * self.unit.tax_percent
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

  def end_date_after_start_date
    return unless self.start_date.present? && self.end_date.present?
    if self.start_date >= self.end_date
      errors[:time] << "must have end date after start date"
    end
  end

  def overlapping_inquiries
    if overlapping?
      errors[:time] << "slot is already filled"
    end
  end

end
