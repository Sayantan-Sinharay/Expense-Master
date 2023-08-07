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
        @user.errors.add(:base, "Invalid email/password combination")
        handle_failed_login
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
    if params[:user][:email].blank? && params[:user][:password].blank?
      @user = User.new
      @user.errors.add(:email, "Email can't be blank")
      @user.errors.add(:password, "Password can't be blank")
      false
    elsif params[:user][:email].blank?
      @user = User.new
      @user.errors.add(:email, "Email can't be blank")
      false
    elsif params[:user][:password].blank?
      @user = User.new
      @user.errors.add(:password, "Password can't be blank")
      false
    else
      true
    end
  end

  def handle_successful_login(user)
    log_in(user)
    redirect_to root_path, success: 'Successfully logged in'
  end

  def handle_failed_login
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
    set_current_user
  end

  def log_out
    reset_session
    cookies.delete :user_id
    # set_current_user(nil)
  end
end
