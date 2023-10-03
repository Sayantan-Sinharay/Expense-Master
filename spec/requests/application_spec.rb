# spec/controllers/application_controller_spec.rb

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
      allow(controller).to receive(:flash).and_return({})
      allow(controller).to receive(:redirect_to).with(root_path)

      controller.send(:handle_not_logged_in)

      expect(controller).to have_received(:flash).with(danger: 'Please login to access the application.')
      expect(controller).to have_received(:redirect_to).with(root_path)
    end
  end

  describe '#authenticate_admin' do
    let(:admin_user) { create(:user, is_admin?: true) }

    it 'calls authenticate_role with is_admin=true' do
      allow(controller).to receive(:authenticate_role).with(true)

      controller.send(:authenticate_admin)

      expect(controller).to have_received(:authenticate_role).with(true)
    end

    it 'redirects to not_found_path when Current.user is nil' do
      allow(controller).to receive(:handle_not_logged_in)
      session[:user_id] = nil
      allow(controller).to receive(:redirect_to).with(not_found_path)

      controller.send(:authenticate_admin)

      expect(controller).to have_received(:handle_not_logged_in)
      expect(controller).to have_received(:redirect_to).with(not_found_path)
    end

    it 'renders the not_found template when Current.user is not an admin' do
      session[:user_id] = user.id
      allow(user).to receive(:is_admin?).and_return(false)
      allow(controller).to receive(:update_invalid_route)
      allow(controller).to receive(:redirect_to).with(not_found_path)

      controller.send(:authenticate_admin)

      expect(controller).to have_received(:update_invalid_route).with(true)
      expect(controller).to have_received(:redirect_to).with(not_found_path)
    end
  end

  describe '#authenticate_user' do
    it 'calls authenticate_role with is_admin=false' do
      allow(controller).to receive(:authenticate_role).with(false)

      controller.send(:authenticate_user)

      expect(controller).to have_received(:authenticate_role).with(false)
    end

    it 'redirects to not_found_path when Current.user is nil' do
      allow(controller).to receive(:handle_not_logged_in)
      session[:user_id] = nil
      allow(controller).to receive(:redirect_to).with(not_found_path)

      controller.send(:authenticate_user)

      expect(controller).to have_received(:handle_not_logged_in)
      expect(controller).to have_received(:redirect_to).with(not_found_path)
    end

    it 'renders the not_found template when Current.user is an admin' do
      session[:user_id] = user.id
      allow(user).to receive(:is_admin?).and_return(true)
      allow(controller).to receive(:update_invalid_route)
      allow(controller).to receive(:redirect_to).with(not_found_path)

      controller.send(:authenticate_user)

      expect(controller).to have_received(:update_invalid_route).with(true)
      expect(controller).to have_received(:redirect_to).with(not_found_path)
    end
  end

  describe '#authenticate_role' do
    it 'handles the case when Current.user is nil' do
      session[:user_id] = nil
      allow(controller).to receive(:handle_not_logged_in)

      controller.send(:authenticate_role, true)

      expect(controller).to have_received(:handle_not_logged_in)
    end

    it 'handles the case when Current.user is an admin and is_admin is true' do
      session[:user_id] = user.id
      allow(user).to receive(:is_admin?).and_return(true)
      allow(controller).to receive(:update_invalid_route)
      allow(controller).to receive(:redirect_to).with(not_found_path)

      controller.send(:authenticate_role, true)

      expect(controller).to have_received(:update_invalid_route).with(true)
      expect(controller).to have_received(:redirect_to).with(not_found_path)
    end

    it 'handles the case when Current.user is not an admin and is_admin is true' do
      session[:user_id] = user.id
      allow(user).to receive(:is_admin?).and_return(false)
      allow(controller).to receive(:update_invalid_route)
      allow(controller).to receive(:redirect_to).with(not_found_path)

      controller.send(:authenticate_role, true)

      expect(controller).to have_received(:update_invalid_route).with(true)
      expect(controller).to have_received(:redirect_to).with(not_found_path)
    end

    it 'handles the case when Current.user is an admin and is_admin is false' do
      session[:user_id] = user.id
      allow(user).to receive(:is_admin?).and_return(true)
      allow(controller).to receive(:update_invalid_route)
      allow(controller).to receive(:redirect_to).with(not_found_path)

      controller.send(:authenticate_role, false)

      expect(controller).to have_received(:update_invalid_route).with(true)
      expect(controller).to have_received(:redirect_to).with(not_found_path)
    end

    it 'updates the invalid route flag to false when Current.user matches is_admin' do
      session[:user_id] = user.id
      allow(user).to receive(:is_admin?).and_return(false)
      allow(controller).to receive(:update_invalid_route)

      controller.send(:authenticate_role, false)

      expect(controller).to have_received(:update_invalid_route).with(false)
    end
  end
end
