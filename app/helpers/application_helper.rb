module ApplicationHelper
  def unread_notification_count(user)
    Notification.unread_count(user.id)
  end
end
