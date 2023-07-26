class UsersController < ApplicationController
  def new
    @user = User.find_signed(params[:token], purpose: 'invitation')
    if @user.nil? || invitation_expired?
      flash[:alert] = 'Invalid or expired invitation link.'
      redirect_to root_path
    end
  end

  def create
    @user = User.find_signed(params[:token], purpose: 'invitation')
    if @user.nil? || invitation_expired?
      flash[:alert] = 'Invalid or expired invitation link.'
      redirect_to root_path
    else
      if @user.update(user_params)
        flash[:notice] = 'Registration completed successfully!'
        send_confirmation_email
        redirect_to root_path
      else
        render :new
      end
    end
  end

  private

  def send_confirmation_email
    UserMailer.with(user: @user).confirmation_email.deliver_later
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def invitation_expired?
    # Check if the user's invitation timestamp is greater than 24 hours ago
    @user.invitation_sent_at.nil? || @user.invitation_sent_at < 24.hours.ago
  end
end
