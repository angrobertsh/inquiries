require 'rails_helper'

RSpec.describe InquiriesController, type: :controller do
  describe 'GET #edit' do
    let!(:user) {FactoryGirl.create(:user)}
    let!(:unit) {FactoryGirl.create(:unit)}
    let!(:day_price) {FactoryGirl.create(:day_price)}
    let!(:inquiry) { FactoryGirl.create(:inquiry) }
    before(:each) do
      get :edit, params: { unit_id: unit.id, id: inquiry.id }
    end

    it { should respond_with(200) }
    it { should render_template(:edit) }

    it 'assigns unit' do
      expect(assigns(:inquiry)).to eq(inquiry)
    end
  end

end
