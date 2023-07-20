# frozen_string_literal: true

# NotificationsController is responsible for managing notifications.
# It inherits from ApplicationController and includes common functionality.

class NotificationsController < ApplicationController
  # GET /notifications - Index action for notifications
  # Fetches all notifications for the current user and orders them by the creation date in descending order.
  # It then marks all notifications as read by calling the private method mark_notifications_as_read.
  def index
    @notifications = Current.user.notifications.order(created_at: :desc)
    mark_notifications_as_read
  end

  # DELETE /notifications/delete - Delete action for notifications
  # This action renders the delete notifications page.
  def delete; end

  private

  # Mark all notifications as read
  def mark_notifications_as_read
    @notifications.update_all(read: true)
  end
end
