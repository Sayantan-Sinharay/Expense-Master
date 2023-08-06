# frozen_string_literal: true

module Users
  # Helper module for the ExpensesController in the user panel.
  module ExpensesHelper
    include NotificationsHelper

    # Sends notifications to admins about the newly created expense.
    def send_notifications(user, expense)
      message = "#{user.first_name} #{user.last_name} has created a new expense of an amount #{expense.amount} " \
                "dated at #{expense.date}."
      create_notification_for_admins(message, expense)
    end
  end
end
