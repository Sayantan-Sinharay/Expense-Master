class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:destroy]
  layout "user"

  def index
    @users = User.get_users()
  end

  def new
    @user = User.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @user = User.invite_user(params[:user][:email])
    respond_to do |format|
      if @user && @user.save
        format.html {
          redirect_to admin_users_path, success: "Invitation sent to #{@user.email}!"
        }
        format.js
        UserMailer.with(user: @user).invitation_email.deliver_later
      else
        format.html {
          flash.now[:danger] = "Failed to send invitation to #{params[:user][:email]}."
          render :new
        }
        format.js
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, error: "User has been successfully deleted." }
      format.js
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
