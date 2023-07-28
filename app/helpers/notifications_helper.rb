# frozen_string_literal: true

# Contains helper methods for handling notifications.
module NotificationsHelper
  # Creates notifications for all admin users with the given notification message.
  def create_notification_for_admins(notification_message, expense)
    admin_users = User.get_admin_users(Current.user[:organization_id])
    admin_users.each do |admin|
      notification = Notification.create(user_id: admin.id, message: notification_message)
      NotificationChannel.broadcast_to(admin.id, partial: render_to_string(partial: 'notifications/notification',locals: { notification: notification }))
      send_request_approval_email_notification(admin, expense)
    end
  end

  # Creates a notification for the specified user with the given notification message.
  def create_notification_for_user(admin, notification_message, expense)
    notification = Notification.create(user_id: expense.user.id, message: notification_message)
    NotificationChannel.broadcast_to(expense.user.id, partial: render_to_string(partial: 'notifications/notification', locals: { notification: notification }))
    send_expense_status_update_email_notification(admin, expense)
  end
end

def send_expense_status_update_email_notification(admin, expense)
  UserMailer.with(admin: admin, expense: expense).expense_status_update_email.deliver_later
end 
