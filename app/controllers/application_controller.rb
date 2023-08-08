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
    Current.user = (User.find_by(id: session[:user_id]) if session[:user_id])
  end

  def logged_in?
    Current.user.present?
  end

  def handle_not_logged_in
    return if logged_in?

    flash[:danger] = 'Please login to access the application.'
    redirect_to root_path
  end

  def authenticate_admin
    if Current.user
      render 'shared/404_page', status: :not_found unless Current.user.is_admin?
    else
      handle_not_logged_in
    end
  end

  def authenticate_user
    if Current.user
      render 'shared/404_page', status: :not_found if Current.user.is_admin?
    else
      handle_not_logged_in
    end
  end
end
