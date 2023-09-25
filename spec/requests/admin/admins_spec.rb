# rubocop:disable all

require 'rails_helper'

RSpec.describe Admin::AdminsController, type: :controller do
  let(:admin_user) { create(:user, is_admin?: true) } # Assuming you have a User model and FactoryBot set up

  before { allow(controller).to receive(:authenticate_admin).and_return(true) }

  describe 'GET #index' do
    context 'when an admin user is authenticated' do
      it 'redirects to admin_dashboards_path' do
        allow(Current).to receive(:user).and_return(admin_user)

        get :index

        expect(response).to redirect_to(admin_dashboards_path)
      end
    end

    context 'when a non-admin user is authenticated' do
      it 'redirects to the root path' do
        non_admin_user = create(:user, is_admin?: false)
        allow(Current).to receive(:user).and_return(non_admin_user)

        get :index

        expect(response).to redirect_to(root_path)
      end
    end

    context 'when no user is authenticated' do
      it 'redirects to login_path' do
        allow(Current).to receive(:user).and_return(nil)

        get :index

        expect(response).to redirect_to(login_path)
      end
    end
  end

  # You can add more test cases as needed for other controller actions or scenarios.
end
