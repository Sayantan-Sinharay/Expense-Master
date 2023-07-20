# frozen_string_literal: true

# The channel for handling real-time notifications.
class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user.id
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
