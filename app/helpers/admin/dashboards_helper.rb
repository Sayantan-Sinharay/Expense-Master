# frozen_string_literal: true

module Admin
  # Helper module for the DashboardsController in the admin panel.
  module DashboardsHelper
    include NotificationsHelper

    # Sends a notification to the user that their expense was approved.
    def send_approve_notification(current_user, expense)
      message = "#{current_user.name} has approved your expense dated at #{expense.date}."
      create_notification_for_user(expense.user, message)
    end

    # Sends a notification to the user that their expense was rejected.
    def send_reject_notification(current_user, expense)
      message = "#{current_user.name} has rejected your expense dated at #{expense.date}."
      create_notification_for_user(expense.user, message)
    end
  end
end
