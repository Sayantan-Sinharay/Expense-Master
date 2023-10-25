# frozen_string_literal: true

# Controller for handling user sessions (login and logout).
class SessionsController < ApplicationController
  skip_before_action :require_login
  before_action :load_user_from_token, only: %i[change_password update_password]
  before_action :new_user, only: %i[new forget_password change_password]

  def new; end

  def create
    @user = User.new(login_params)
    if load_user && authenticate_user
      handle_successful_login
    else
      handle_failed_login('Invalid email/password combination')
    end
  end

  def destroy
    log_out
    redirect_to root_path, success: 'Logged out successfully'
  end

  def forget_password; end

  def reset_password
    @user = User.find_by(email: forget_password_params[:email])
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

  def load_user_from_token
    @user = User.find_signed(params[:token], purpose: 'reset password')
  end

  def load_user
    return if @user.valid?

    return unless @user.errors.where(:email).first.type == :taken && @user.errors.where(:password).none? do |error|
                    error.type == :blank
                  end

    @user = User.find_by(email: login_params[:email])
  end

  def authenticate_user
    @user.authenticate(login_params[:password])
  end

  def handle_successful_login
    log_in(@user)
    redirect_to root_path, success: 'Successfully logged in'
  end

  def handle_failed_login(message)
    flash.now[:danger] = message
    render :new
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
    @user.update(change_password_params)
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end

  def forget_password_params
    params.require(:user).permit(:email)
  end

  def change_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def new_user
    @user = User.new
  end
end
