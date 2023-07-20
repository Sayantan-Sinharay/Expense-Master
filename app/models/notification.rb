# frozen_string_literal: true

# Represents the notification model in the application.
class Notification < ApplicationRecord
  belongs_to :user

  # Scope to get the count of unread notifications for a given user.
  scope :unread_count, lambda { |user_id|
                         where(user_id:, read: false).count
                       }
end
