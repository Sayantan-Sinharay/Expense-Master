# rubocop:disable all

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'redirects to root_path' do
        post :create, params: { user: { email: user.email, password: 'password' } }
        expect(response).to redirect_to(root_path)
      end

      it 'logs in the user' do
        expect(controller).to receive(:log_in).with(user)
        post :create, params: { user: { email: user.email, password: 'password' } }
      end
    end

    context 'with invalid params' do
      it 'renders the new template' do
        post :create, params: { user: { email: '', password: '' } }
        expect(response).to render_template(:new)
      end

      it 'displays an error message' do
        post :create, params: { user: { email: '', password: '' } }
        expect(flash[:danger]).to include("Email can't be blank")
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to root_path' do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end

    it 'logs out the user' do
      expect(controller).to receive(:log_out)
      delete :destroy
    end
  end

  describe 'GET #forget_password' do
    it 'renders the forget_password template' do
      get :forget_password
      expect(response).to render_template(:forget_password)
    end
  end

  describe 'POST #reset_password' do
    context 'with valid email' do
      it 'redirects to root_path' do
        post :reset_password, params: { user: { email: user.email } }
        expect(response).to redirect_to(root_path)
      end

      it 'generates a reset password token and sends an email' do
        expect(controller).to receive(:generate_reset_password_token).with(user)
        post :reset_password, params: { user: { email: user.email } }
      end
    end

    context 'with invalid email' do
      it 'renders the forget_password template' do
        post :reset_password, params: { user: { email: 'invalid@example.com' } }
        expect(response).to render_template(:forget_password)
      end

      it 'displays an error message' do
        post :reset_password, params: { user: { email: 'invalid@example.com' } }
        expect(flash[:danger]).to include('The email entered is Invalid')
      end
    end
  end

  describe 'GET #change_password' do
    it 'renders the change_password template' do
      get :change_password
      expect(response).to render_template(:change_password)
    end
  end

  describe 'PATCH #update_password' do
    context 'with valid params' do
      it 'redirects to login_path' do
        patch :update_password, params: { user: { password: 'New_password123', password_confirmation: 'New_password123
          ' } }
        expect(response).to redirect_to(login_path)
      end

      it 'displays a success message' do
        patch :update_password, params: { user: { password: 'New_password123', password_confirmation: 'New_password123' } }
        expect(flash[:success]).to include('Your password has been reset')
      end
    end

    context 'with invalid params' do
      it 'renders the change_password template' do
        patch :update_password, params: { user: { password: '', password_confirmation: '' } }
        expect(response).to render_template(:change_password)
      end

      it 'displays an error message' do
        patch :update_password, params: { user: { password: '', password_confirmation: '' } }
        expect(flash[:danger]).to include("Password can't be blank")
      end
    end
  end
end
