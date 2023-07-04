class Admin::UsersController < ApplicationController
  layout "user"

  def index
    @users = User.get_users()
  end

  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    @user = User.invite_user(params[:user][:email])
    response_to do |format|
      if user && user.save
        # format.html { redirect_to
        format.js
        UserMailer.with(user: @user).invitation_email.deliver_later
        flash[:notice] = "Invitation sent to #{@user.email}!"
      else
        format.js
        flash[:alert] = "Failed to send invitation to #{params[:user][:email]}."
      end
      format.html { redirect_to admin_users_path }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User has been successfully deleted."
  end
end
