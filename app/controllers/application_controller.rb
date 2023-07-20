# frozen_string_literal: true

# Base controller for the application.
class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success
  before_action :set_current_user

  def set_current_user
    return unless session[:user_id]

    Current.user = User.find_by(id: session[:user_id])
  end

  # def go_back
  #   redirect_back(fallback_location: root_path)
  # end
end
