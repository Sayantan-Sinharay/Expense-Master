# frozen_string_literal: true

# ApplicationController is the base controller for the application.
class ApplicationController < ActionController::Base
  include ApplicationHelper

  add_flash_types :info, :error, :success

  before_action :set_current_user, :require_login, :set_no_cache

  private

  def set_current_user
    Current.user = session[:user_id] ? User.find_by(id: session[:user_id]) : nil
  end

  def require_login
    return if Current.user

    flash[:danger] = 'Please login to access the application.'
    redirect_to root_path
  end

  def authenticate_admin
    authenticate_role({ is_admin?: true })
  end

  def authenticate_user
    authenticate_role({ is_admin?: false })
  end

  def authenticate_role(role)
    return unless Current.user&.is_admin? != role[:is_admin?]

    update_invalid_route(true)
    redirect_to not_found_path
  end

  def set_no_cache
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '-1'
  end
end
