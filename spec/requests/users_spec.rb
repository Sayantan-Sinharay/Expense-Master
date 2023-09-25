# rubocop:disable all
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:invitation_token) { 'valid_invitation_token' }
  let(:user_params) do
    { first_name: 'John', last_name: 'Doe', password: 'Password#123', password_confirmation: 'Password#123' }
  end
  let(:valid_user) { create(:user, invitation_sent_at: Time.now) } # Change create(:user_params) to create(:user)

  describe 'GET #new' do
    context 'with a valid invitation token' do
      it 'finds the user and renders the new template' do
        signed_token = valid_user.signed_id(purpose: 'invitation')
        get :new, params: { token: signed_token }
        expect(assigns(:user)).to eq(valid_user)
        expect(response).to render_template(:new)
      end
    end

    context 'with an invalid or expired invitation token' do
      it 'sets a flash alert and redirects to root_path' do
        get :new, params: { token: 'invalid_token' }
        expect(flash[:alert]).to eq('Invalid or expired invitation link.')
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    context 'with a valid invitation token and user parameters' do
      it 'registers the user, sends a confirmation email, and redirects to root_path' do
        signed_token = valid_user.signed_id(purpose: 'invitation')
        allow(controller).to receive(:send_confirmation_email)

        post :create, params: { token: signed_token, user: user_params }

        expect(valid_user.reload.first_name).to eq('John')
        expect(controller).to have_received(:send_confirmation_email).once
        expect(flash[:notice]).to eq('Registration completed successfully!')
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with an invalid or expired invitation token' do
      it 'sets a flash alert and redirects to root_path' do
        post :create, params: { token: 'invalid_token', user: user_params }
        expect(flash[:alert]).to eq('Invalid or expired invitation link.')
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid user parameters' do
      it 'renders the new template' do
        signed_token = valid_user.signed_id(purpose: 'invitation')

        post :create, params: { token: signed_token, user: { password: 'password' } }

        expect(response).to render_template(:new)
      end
    end
  end
end