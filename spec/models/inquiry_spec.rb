require 'rails_helper'

RSpec.describe Inquiry, type: :model do

  let!(:user) {FactoryGirl.create(:user)}
  let!(:unit) {FactoryGirl.create(:unit)}
  let!(:day_price) {FactoryGirl.create(:day_price)}
  let!(:day_price2) {FactoryGirl.create(:day_price, date: Date.new(2016, 06, 21), price: 1)}
  let!(:inquiry) {FactoryGirl.create(:inquiry)}

  describe 'basic validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:unit_id) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
  end

  describe 'custom validations' do
    context 'when given a end date greater than start date' do
      let(:inquiry2) {FactoryGirl.create(:inquiry, end_date: Date.new(2015, 06, 13), start_date: Date.new(2016, 06, 01))}
      it 'should make sure end date is greater than start date' do
        expect{inquiry2.save!}.to raise_error(/must have end date after start date/)
      end
    end
    context 'when given an overlapping date' do
      let(:inquiry3) {FactoryGirl.create(:inquiry)}
      it 'should make sure overlapping inquiries are invalid' do
        expect{inquiry3.save!}.to raise_error(/Time slot is already filled/)
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:unit) }
  end

  describe 'instance_methods' do

    describe '#set_price_and_taxes' do
      context 'when given a unit' do
        it 'should set total_price' do
          expect(inquiry.total_price).to eq(day_price.price)
        end
        it 'should set taxes_withheld' do
          expect(inquiry.taxes_withheld).to eq(unit.tax_percent * day_price.price)
        end
      end
    end

    describe '#reset_price_and_taxes' do
      it 'resets the total_price' do
        inquiry.start_date = day_price2.date
        inquiry.end_date = day_price2.date+1
        inquiry.reset_price_and_taxes!
        expect(inquiry.total_price).to eq(day_price2.price)
      end
      it 'resets the taxes' do
        inquiry.start_date = day_price2.date
        inquiry.end_date = day_price2.date+1
        inquiry.reset_price_and_taxes!
        expect(inquiry.total_price).not_to eq(unit.tax_percent * day_price2.price)
      end
    end

    describe '#day_prices' do
      it 'should return the correct day_prices records' do
        expect(inquiry.day_prices).to eq([day_price])
      end
    end

    describe '#overlapping?' do
      it 'should find if there are overlapping records' do
        inquiry3 = Inquiry.new(end_date: Date.new(2016, 06, 20), start_date: Date.new(2016, 06, 21), unit_id: 1, user_id: 1)
        expect(inquiry3.overlapping?).to eq(true)
      end
    end

    # Protected method not tested
    # describe '.end_date_after_start_date' do
    #   it 'should check if end dates are before start dates' do
    #     inquiry3 = Inquiry.new(end_date: Date.new(2016, 06, 20), start_date: Date.new(2016, 06, 01), unit_id: 1, user_id: 1)
    #     expect(inquiry3.end_date_after_start_date).to eq(false)
    #   end
    # end

  end

  describe 'model_methods' do
    describe '.overlapping(inquiry)' do
      context 'when given an overlapping inquiry' do
        it 'should return overlapping inquiries' do
          inquiry3 = Inquiry.new(end_date: Date.new(2016, 06, 20), start_date: Date.new(2016, 06, 21), unit_id: 1, user_id: 1)
          expect(Inquiry.overlapping(inquiry3)).to eq([inquiry])
        end
      end
      context 'when given non-overlapping inquiry' do
        let(:inquiry4) {FactoryGirl.create(:inquiry, start_date: Date.new(2016, 9, 1), end_date: Date.new(2016, 9, 4), unit_id: 1, user_id: 1)}
        it 'should return an empty array' do
          expect(Inquiry.overlapping(inquiry4)).to eq([])
        end
      end
    end
  end

end
