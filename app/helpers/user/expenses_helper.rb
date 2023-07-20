# frozen_string_literal: true

module User::ExpensesHelper
  include NotificationsHelper

  def update_month_and_year(expense)
    year = expense[:date].year
    month = expense[:date].month
    expense.update(year:, month:)
  end

  def send_notifications(user, expense)
    message = "#{user.name} has created a new expense of an amount #{expense.amount} dated at #{expense.date}."
    create_notification_for_admins(message)
  end
end
