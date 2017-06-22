require 'rails_helper'

RSpec.describe Unit, type: :model do
  let!(:unit) {FactoryGirl.create(:unit)}

  it "sets value properly" do
    expect(unit.tax_percent).to eq(0.20)
  end

  describe 'associations' do
    it { should have_many(:day_prices) }
  end
end
