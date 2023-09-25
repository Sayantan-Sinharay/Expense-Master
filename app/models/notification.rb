# frozen_string_literal: true

# Represents the notification model in the application.
class Notification < ApplicationRecord
  belongs_to :user, inverse_of: :notifications

  scope :unread_count, lambda { |user_id|
    where(user_id:, read: false).count
  }
end
