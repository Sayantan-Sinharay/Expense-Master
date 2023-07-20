# frozen_string_literal: true

module Users
  # Helper module for the ExpensesController in the user panel.
  module ExpensesHelper
    include NotificationsHelper

    # Updates the year and month attributes of an expense based on the expense's date.
    def update_month_and_year(expense)
      year = expense[:date].year
      month = expense[:date].month
      expense.update(year:, month:)
    end

    # Sends notifications to admins about the newly created expense.
    def send_notifications(user, expense)
      message = "#{user.name} has created a new expense of an amount #{expense.amount} dated at #{expense.date}."
      create_notification_for_admins(message)
    end
  end
end
