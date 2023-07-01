class Admin::UsersController < ApplicationController
  layout "../admin/admins/index"

  def index
    @users = User.get_users()
  end

  def new
  end

  def create
    @user = User.invite_user(params[:user][:email])
    if @user.persisted?
      UserMailer.with(user: @user).invitation_email.deliver_later
      flash[:notice] = "Invitation sent to #{@user.email}!"
    else
      flash[:alert] = "Failed to send invitation to #{params[:user][:email]}."
    end
    redirect_to admin_users_path
  end

  def destroy
  end
end
