# frozen_string_literal: true

# Controller for managing notifications.
class NotificationsController < ApplicationController
  after_action :mark_notifications_as_read, only: :index
  def index
    @notifications = Current.user.notifications.order(created_at: :desc)
  end

  # implement it later
  def delete; end

  private

  # Mark all notifications as read
  def mark_notifications_as_read
    @notifications.update_all(read: true)
  end
end
