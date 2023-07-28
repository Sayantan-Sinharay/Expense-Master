# frozen_string_literal: true

module Admin
  # Helper module for the DashboardsController in the admin panel.
  module DashboardsHelper
    include NotificationsHelper

    # Sends a notification to the user that their expense was approved.
    def send_expense_status_update_notification(current_user, expense)
      message = "#{current_user.first_name} #{current_user.last_name} has #{expense.status} your expense dated at #{expense.date}"
      create_notification_for_user(current_user, message, expense)
    end
  end
end
