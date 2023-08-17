# frozen_string_literal: true

# FlashesChannel is a WebSocket channel for broadcasting flash messages to specific users.
# It allows users to receive real-time flash messages when they are subscribed to the channel.
class FlashesChannel < ApplicationCable::Channel
  def subscribed
    stream_from current_user.id
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
