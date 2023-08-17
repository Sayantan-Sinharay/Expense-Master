# frozen_string_literal: true

# ApplicationController is the base controller for the application.
# It inherits from ActionController::Base, providing common functionalities
# and setting up necessary actions for all other controllers.
class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Define additional flash types to be used in views.
  add_flash_types :info, :error, :success

  # Before any action is executed, set the current user based on the session data.
  before_action :set_current_user

  def logged_in?
    Current.user.present?
  end

  def handle_not_logged_in
    return if logged_in?

    flash[:danger] = 'Please login to access the application.'
    redirect_to root_path
  end

  def authenticate_admin
    authenticate_role(true, 'shared/404_page', :not_found)
  end

  def authenticate_user
    authenticate_role(false, 'shared/404_page', :not_found)
  end

  private

  def authenticate_role(is_admin, error_template, status)
    return handle_not_logged_in unless Current.user

    if Current.user.is_admin? == is_admin
      update_invalid_route(true)
    else
      update_invalid_route(false)
      render_error_template(error_template, status)
    end
  end

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def render_error_template(error_template, status)
    render template: error_template, status:
  end
end
