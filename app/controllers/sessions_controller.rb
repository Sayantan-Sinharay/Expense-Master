# frozen_string_literal: true

# Controller for handling user sessions (login and logout).
class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if validate_params
      @user = User.find_by(email: params[:user][:email].downcase)

      if @user&.authenticate(params[:user][:password])
        handle_successful_login(@user)
      else
        handle_failed_login('Invalid email/password combination')
      end
    else
      render :new
    end
  end

  def destroy
    handle_logout
  end

  private

  def validate_params
    valid_params = validate_email && validate_password
    @user = User.new
    @user.errors.add(:email, "Email can't be blank") unless validate_email
    @user.errors.add(:password, "Password can't be blank") unless validate_password
    valid_params
  end

  def validate_email
    params[:user][:email].present?
  end

  def validate_password
    params[:user][:password].present?
  end

  def handle_successful_login(user)
    log_in(user)
    redirect_to root_path, success: 'Successfully logged in'
  end

  def handle_failed_login(message)
    @user = User.new
    @user.errors.add(:base, message)
    flash.now[:danger] = @user.errors.full_messages.join(', ')
    render :new
  end

  def handle_logout
    log_out
    redirect_to root_path, success: 'Logged out successfully'
  end

  def log_in(user)
    session[:user_id] = user.id
    cookies.signed[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    reset_session
    cookies.delete :user_id
  end
end
