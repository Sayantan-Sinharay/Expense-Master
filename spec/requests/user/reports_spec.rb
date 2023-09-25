# rubocop:disable all

require 'rails_helper'


RSpec.describe Users::ReportsController, type: :controller do
  let(:user) { create(:user) }
  let(:approved_expense) { create(:expense, :user, status: 'approved')}



  before { allow(controller).to receive(:authenticate_user).and_return(true) }

  describe 'GET #index' do
    it 'assigns yearly_data and category_data and renders the index template' do
      allow(Current).to receive(:user).and_return(user)
      yearly_data = { '2023' => 1000, '2022' => 800 }
      category_data = { 'Category 1' => 500, 'Category 2' => 400 }
      get :index

      expect(assigns(:yearly_data)).to eq(yearly_data)
      expect(assigns(:category_data)).to eq(category_data)
      expect(response).to render_template(:index)
    end
  end
end
