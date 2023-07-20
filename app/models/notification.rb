class Notification < ApplicationRecord
  belongs_to :user

  scope :unread_count, ->(user_id) {
          where(user_id: user_id, read: false).count
        }
end
