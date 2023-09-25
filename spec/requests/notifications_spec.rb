# rubocop:disable all

require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let(:user) { create(:user) } # Assuming you have a User model and FactoryBot set up
  let(:notification1) { create(:notification, user:, read: false) }
  let(:notification2) { create(:notification, user:, read: false) }

  before { allow(controller).to receive(:authenticate_user).and_return(true) }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns the user\'s notifications to @notifications' do
      user.notifications << [notification1, notification2]

      get :index

      expect(assigns(:notifications)).to eq([notification2, notification1]) # Ordered by created_at: :desc
    end

    it 'marks all notifications as read' do
      user.notifications << [notification1, notification2]

      expect(controller).to receive(:mark_notifications_as_read).once

      get :index
    end
  end
end
