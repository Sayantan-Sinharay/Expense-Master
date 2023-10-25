# frozen_string_literal: true

# Controller for managing notifications.
class NotificationsController < ApplicationController
  after_action :mark_notifications_as_read, only: :index

  def index
    @notifications = Current.user.notifications.order(created_at: :desc)
  end

  private

  def mark_notifications_as_read
    @notifications.find_each { |notification| notification.update(read: true) }
  end
end
