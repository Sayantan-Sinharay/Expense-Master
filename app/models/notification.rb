# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user

  scope :unread_count, lambda { |user_id|
                         where(user_id:, read: false).count
                       }
end
