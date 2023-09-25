# rubocop:disable all

require 'rails_helper'

RSpec.describe Users::UsersController, type: :controller do
  let(:user) { create(:user) } # Assuming you have a User model and FactoryBot set up

  before { allow(controller).to receive(:authenticate_user).and_return(true) }

  describe 'GET #index' do
    it 'redirects to budgets_path' do
      allow(Current).to receive(:user).and_return(user)

      get :index

      expect(response).to redirect_to(budgets_path)
    end
  end

  # You can add more test cases as needed for other controller actions or scenarios.
end
