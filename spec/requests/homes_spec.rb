# rubocop:disable all

require 'rails_helper'

RSpec.describe HomesController, type: :controller do
  let(:user) { create(:user) }  # Assuming you have a User model and FactoryBot set up

  describe 'GET #index' do
    context 'when a user is logged in as an admin' do
      it 'redirects to admin_index_path' do
        allow(controller).to receive(:authenticate_user).and_return(true)
        allow(Current).to receive(:user).and_return(user)
        allow(user).to receive(:is_admin?).and_return(true)

        get :index

        expect(response).to redirect_to(admin_index_path)
      end
    end

    context 'when a user is logged in as a regular user' do
      it 'redirects to index_path' do
        allow(controller).to receive(:authenticate_user).and_return(true)
        allow(Current).to receive(:user).and_return(user)
        allow(user).to receive(:is_admin?).and_return(false)

        get :index

        expect(response).to redirect_to(index_path)
      end
    end

    context 'when no user is logged in' do
      it 'redirects to login_path' do
        allow(controller).to receive(:authenticate_user).and_return(false)

        get :index

        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
