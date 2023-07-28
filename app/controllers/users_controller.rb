# frozen_string_literal: true

# Controller for managing user account for users.
class UsersController < ApplicationController
  # Display the registration form for invited users.
  def new
    @user = User.find_signed(params[:token], purpose: 'invitation')
    return unless invalid_or_expired_invitation?

    flash[:alert] = 'Invalid or expired invitation link.'
    redirect_to root_path
  end

  # Process the user registration form submitted by invited users.
  def create
    @user = User.find_signed(params[:token], purpose: 'invitation')

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

  # Sends a confirmation email to the newly registered user.
  def send_confirmation_email
    UserMailer.with(user: @user).confirmation_email.deliver_later
  end

  # Permits the user registration parameters.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation)
  end

  # Checks if the user's invitation link has expired (older than 24 hours).
  def invitation_expired?
    @user.invitation_sent_at.nil? || @user.invitation_sent_at < 24.hours.ago
  end

  # Checks if the user's invitation is invalid or expired.
  def invalid_or_expired_invitation?
    @user.nil? || invitation_expired?
  end

  # Registers the user based on the submitted form data.
  def register_user
    @user.update(user_params)
  end

  # Handles invalid or expired invitation.
  def handle_invalid_invitation(format)
    flash[:alert] = 'Invalid or expired invitation link.'
    format.html { redirect_to root_path }
  end

  # Handles successful user registration.
  def handle_successful_registration(format)
    flash[:notice] = 'Registration completed successfully!'
    send_confirmation_email
    format.html { redirect_to root_path }
  end
end
