# rubocop:disable all

require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'scopes' do
    describe '.unread_count' do
      it 'returns the count of unread notifications for a user' do
        user = create(:user)

        # Create unread notifications for the user
        create_list(:notification, 3, user:, read: false)

        # Create read notifications for the user
        create_list(:notification, 2, user:, read: true)

        unread_count = Notification.unread_count(user.id)

        expect(unread_count).to eq(3)
      end
    end
  end
end
