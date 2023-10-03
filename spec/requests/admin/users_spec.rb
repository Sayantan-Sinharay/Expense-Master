# rubocop:disable all

require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:organization) { create(:organization) }
  let(:admin_user) { create(:user, organization: , is_admin?: true) } # Assuming you have a User model and FactoryBot set up
  let(:user) { create(:user, organization:, is_admin?: false) } # Assuming you have a User model and FactoryBot set up

  before { allow(controller).to receive(:authenticate_admin).and_return(true) }

  describe 'GET #index' do
    it 'assigns users and renders the index template' do
      allow(Current).to receive(:user).and_return(admin_user)
      users = [user]

      get :index

      expect(assigns(:users)).to eq(users)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new user and renders the new.js.erb template' do
      allow(Current).to receive(:user).and_return(admin_user)

      get :new, format: :js

      expect(assigns(:user)).to be_a_new(User)
      expect(response).to render_template('admin/users/new')
    end
  end

  describe 'POST #create' do
    context 'with a valid email' do
      it 'creates a new user, sends invitation email, and redirects to admin_users_path' do
        allow(Current).to receive(:user).and_return(admin_user)
        allow(controller).to receive(:valid_email?).and_return(true)
        allow(UserMailer).to receive_message_chain(:with, :invitation_email, :deliver_later)

        post :create, params: { user: { email: 'newuser@example.com' } }

        expect(User.count).to eq(1)
        expect(flash[:success]).to eq('Invitation sent to newuser@example.com!')
        expect(response).to redirect_to(admin_users_path)
        expect(UserMailer).to have_received(:with).once
      end
    end

    context 'with an invalid email' do
      it 'renders the new.js.erb template' do
        allow(Current).to receive(:user).and_return(admin_user)
        allow(controller).to receive(:valid_email?).and_return(false)

        post :create, params: { user: { email: '' } }, format: :js

        expect(response).to render_template('admin/users/new')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the user, sends notification, and renders destroy.js.erb' do
      allow(Current).to receive(:user).and_return(admin_user)
      allow(controller).to receive(:send_flash)

      delete :destroy, params: { id: user.id }, format: :js

      expect(User.count).to eq(0)
      expect(controller).to have_received(:send_flash).once
      expect(response).to render_template('admin/users/destroy')
    end
  end

  # You can add more test cases as needed for other controller actions or scenarios.
end
