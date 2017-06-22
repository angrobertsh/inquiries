require 'rails_helper'

RSpec.describe Inquiry, type: :model do

  # There are problems initializing a factory inquiry here and I didn't have enough time to fix them

  let!(:user) {FactoryGirl.create(:user)}
  let!(:unit) {FactoryGirl.create(:unit)}
  let!(:day_price) {FactoryGirl.create(:day_price)}
  let!(:inquiry) {FactoryGirl.create(:inquiry, unit: unit, user: user)}

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:unit_id) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    # it { should validate_presence_of(:taxes_withheld) }
    # it { should validate_presence_of(:total_price) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:unit) }
  end

  describe 'model_methods' do
    describe '.set_price_and_taxes' do
      context 'when given a unit' do
        it 'should have access to a unit tax_percent' do
          expect(inquiry.unit.tax_percent).to eq(unit.tax_percent)
        end
        it 'have the same unit' do
          expect(inquiry.unit_id).to eq(unit.id)
        end
        it 'have the same unit' do
          expect(inquiry.unit).to eq(unit)
        end
      end



      # context 'when given incorrect credentials' do
      #   it 'should return nil' do
      #     incorrect_user = User.find_by_credentials('guest', 'wrongpw')
      #     expect(incorrect_user).to eq(nil)
      #   end
      # end
    end
  end

  # describe 'instance_methods' do
  #   describe '#reset_session_token!' do
  #     it 'resets the session token' do
  #       old_token = user.session_token
  #       new_token = user.reset_session_token!
  #       expect(old_token).not_to eq(new_token)
  #     end
  #   end
  #
  # end

  # describe 'model_methods' do
  #   describe '.find_by_credentials' do
  #     context 'when given correct credentials' do
  #       it 'should find the right user' do
  #         correct_user = User.find_by_credentials('guest', 'password')
  #         expect(correct_user).to eq(user)
  #       end
  #     end
  #
  #     context 'when given incorrect credentials' do
  #       it 'should return nil' do
  #         incorrect_user = User.find_by_credentials('guest', 'wrongpw')
  #         expect(incorrect_user).to eq(nil)
  #       end
  #     end
  #   end
  # end
  #
  # describe 'instance_methods' do
  #   describe '#reset_session_token!' do
  #     it 'resets the session token' do
  #       old_token = user.session_token
  #       new_token = user.reset_session_token!
  #       expect(old_token).not_to eq(new_token)
  #     end
  #   end
  #
  # end

end
