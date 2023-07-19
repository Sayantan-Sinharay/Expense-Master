class NotificationsController < ApplicationController
  def index
    @notifications = Current.user.notifications.order(created_at: :desc)
    mark_notifications_as_read
  end

  def delete
  end

  private

  def mark_notifications_as_read
    @notifications.update_all(read: true)
  end
end
