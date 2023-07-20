# frozen_string_literal: true

# ApplicationController is the base controller for the application.
# It inherits from ActionController::Base, providing common functionalities
# and setting up necessary actions for all other controllers.
class ApplicationController < ActionController::Base
  # Define additional flash types to be used in views.
  add_flash_types :info, :error, :success

  # Before any action is executed, set the current user based on the session data.
  before_action :set_current_user

  # Set the current user based on the user_id stored in the session.
  def set_current_user
    return unless session[:user_id]

    Current.user = User.find_by(id: session[:user_id])
  end
end

