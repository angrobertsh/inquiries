require 'rails_helper'

RSpec.describe UnitsController, type: :controller do

  describe 'GET #show' do
    let (:unit_1) { FactoryGirl.create(:unit) }
    before(:each) do
      get :show, params: { id: unit_1.id }
    end

    it { should render_template(:show) }
    it { should respond_with(200) }

    it 'assigns unit' do
      expect(assigns(:unit)).to eq(unit_1)
    end
  end

  describe 'GET #index' do

    let(:unit_1) { FactoryGirl.create(:unit) }
    before(:each) do
      get :index
    end

    it { should respond_with(200) }
    it { should render_template(:index) }

    it 'assigns all units' do
      expect(assigns(:units)).to eq([unit_1])
    end

  end

end
