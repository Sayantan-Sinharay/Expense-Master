# frozen_string_literal: true

# Contains helper methods for the application.
module ApplicationHelper
  # Returns the count of unread notifications for a given user.
  def unread_notification_count(user)
    Notification.unread_count(user.id)
  end

  def update_invalid_route(value)
    @is_invalid_route = value
  end

  def invalid_route?
    @invalid_route ||= false
  end
end
