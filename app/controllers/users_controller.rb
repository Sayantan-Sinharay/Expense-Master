# frozen_string_literal: true

# Controller for managing user account for users.
class UsersController < ApplicationController
  before_action :find_user_by_token, only: %i[new create]

  def new
    return unless invalid_or_expired_invitation?

    flash[:alert] = 'Invalid or expired invitation link.'
    redirect_to root_path
  end

  def create
    respond_to do |format|
      if invalid_or_expired_invitation?
        handle_invalid_invitation(format)
      elsif register_user
        handle_successful_registration(format)
      else
        format.html { render :new }
      end
    end
  end

  private

  def send_confirmation_email
    UserMailer.with(user: @user).confirmation_email.deliver_later
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation)
  end

  def invitation_expired?
    @user.invitation_sent_at.nil? || @user.invitation_sent_at < 24.hours.ago
  end

  def invalid_or_expired_invitation?
    @user.nil? || invitation_expired?
  end

  def register_user
    @user.update(user_params)
  end

  def handle_invalid_invitation(format)
    flash[:alert] = 'Invalid or expired invitation link.'
    format.html { redirect_to root_path }
  end

  def handle_successful_registration(format)
    flash[:notice] = 'Registration completed successfully!'
    send_confirmation_email
    format.html { redirect_to root_path }
  end

  def find_user_by_token
    @user = User.find_signed(params[:token], purpose: 'invitation')
  end
end
