require 'rails_helper'

RSpec.describe DayPrice, type: :model do
  describe 'associations' do
    it { should belong_to(:unit) }
  end
end
