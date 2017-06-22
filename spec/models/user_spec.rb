require 'rails_helper'

RSpec.describe User, type: :model do

  let!(:user) { User.create!(name:'Testuser', email: 'test@test.com', phone_number: '1-(213)-412-4312') }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'associations' do
    it { should have_many(:inquiries) }
  end

end
