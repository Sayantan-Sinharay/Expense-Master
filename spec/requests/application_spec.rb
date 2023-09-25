# rubocop:disable all

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:user) { create(:user) }

  describe 'before_action :set_current_user' do
    it 'sets Current.user if a user is in the session' do
      session[:user_id] = user.id
      controller.send(:set_current_user)
      expect(Current.user).to eq(user)
    end

    it 'does not set Current.user if session[:user_id] is not present' do
      session[:user_id] = nil

      controller.send(:set_current_user)

      expect(Current.user).to be_nil
    end
  end

  describe '#handle_not_logged_in' do
    it 'sets a flash message and redirects to the root path' do
      controller.send(:handle_not_logged_in)

      expect(flash[:danger]).to eq('Please login to access the application.')
      expect(response).to redirect_to(root_path)
    end
  end

  describe '#authenticate_admin' do
    let(:admin_user) { create(:user, is_admin?: true) }
    it 'calls authenticate_role with is_admin=true' do
      expect(controller).to receive(:authenticate_role).with(true, 'shared/404_page', :not_found)

      controller.send(:authenticate_admin)
    end

    it 'redirects to root_path when Current.user is nil' do
      session[:user_id] = nil
      allow(controller).to receive(:handle_not_logged_in).and_return(false)

      expect(controller).to receive(:handle_not_logged_in)
      controller.send(:authenticate_admin)
    end

    it 'renders the error template when Current.user is not an admin' do
      session[:user_id] = user.id
      allow(user).to receive(:is_admin?).and_return(false)

      expect(controller).to receive(:render_error_template).with('shared/404_page', :not_found)

      controller.send(:authenticate_admin)
    end
  end

  describe '#authenticate_user' do
    it 'calls authenticate_role with is_admin=false' do
      expect(controller).to receive(:authenticate_role).with(false, 'shared/404_page', :not_found)

      controller.send(:authenticate_user)
    end

    it 'redirects to root_path when Current.user is nil' do
      session[:user_id] = nil
      allow(controller).to receive(:handle_not_logged_in).and_return(false)

      expect(controller).to receive(:handle_not_logged_in)
      controller.send(:authenticate_user)
    end

    it 'renders the error template when Current.user is an admin' do
      session[:user_id] = user.id
      allow(user).to receive(:is_admin?).and_return(true)

      expect(controller).to receive(:render_error_template).with('shared/404_page', :not_found)

      controller.send(:authenticate_user)
    end
  end

  describe '#render_error_template' do
    it 'renders the specified error template with the given status' do
      error_template = 'shared/custom_error_template'
      status = :unprocessable_entity

      expect(controller).to receive(:render).with(template: error_template, status: status)

      controller.send(:render_error_template, error_template, status)
    end
  end
end
