# frozen_string_literal: true

module NotificationsHelper
  def create_notification_for_admins(notification_message)
    admin_users = User.get_admin_users(Current.user[:organization_id])
    admin_users.each do |admin|
      notification = Notification.create(user_id: admin.id, message: notification_message)
      NotificationChannel.broadcast_to(admin.id,
                                       partial: render_to_string(partial: 'notifications/notification',
                                                                 locals: { notification: }))
    end
  end

  def create_notification_for_user(user, notification_message)
    notification = Notification.create(user_id: user.id, message: notification_message)
    NotificationChannel.broadcast_to(user.id,
                                     partial: render_to_string(partial: 'notifications/notification',
                                                               locals: { notification: }))
  end
end
