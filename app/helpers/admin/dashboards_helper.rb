module Admin::DashboardsHelper
  include NotificationsHelper

  def send_approve_notification(current_user, expense)
    message = "#{current_user.name} has approved your expense dated at #{expense.date}."
    create_notification_for_user(expense.user, message)
  end

  def send_reject_notification(current_user, expense)
    message = "#{current_user.name} has rejected your expense dated at #{expense.date}."
    create_notification_for_user(expense.user, message)
  end
end
