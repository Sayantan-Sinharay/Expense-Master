# frozen_string_literal: true

# Controller for handling user sessions (login and logout).
class SessionsController < ApplicationController
  before_action :load_user, only: %i[create reset_password]
  before_action :load_user_from_token, only: %i[change_password update_password]

  def new
    @user = User.new
  end

  def create
    if validate_params
      if authenticate_user
        handle_successful_login
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

  def forget_password; end

  def reset_password
    if @user.present?
      generate_reset_password_token
      flash[:success] = 'A reset password link has been sent to your email'
      redirect_to root_path
    else
      flash[:danger] = 'The email entered is Invalid'
      render :forget_password
    end
  end

  def change_password; end

  def update_password
    if update_user_password
      flash[:success] = 'Your password has been reset'
      redirect_to login_path
    else
      flash.now[:danger] = 'An error has occurred'
      render :change_password
    end
  end

  private

  def load_user
    @user = User.find_by(email: params[:user][:email].downcase)
  end

  def load_user_from_token
    @user = User.find_signed(params[:token], purpose: 'reset password')
  end

  def validate_params
    valid_params = validate_email && validate_password
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

  def authenticate_user
    @user&.authenticate(params[:user][:password])
  end

  def handle_successful_login
    log_in(@user)
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

  def generate_reset_password_token
    token = @user.signed_id(purpose: 'reset password', expires_in: 24.hours)
    @user.update(reset_password_token: token, reset_password_sent_at: Time.now)
    UserMailer.with(user: @user).reset_password_email(token).deliver_later
  end

  def update_user_password
    @user.update(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
  end
end
