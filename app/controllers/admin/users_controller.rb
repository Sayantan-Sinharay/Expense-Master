class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:destroy]
  layout "user"

  def index
    @users = User.get_non_admin_users(Current.user[:organization_id])
  end

  def new
    @user = User.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @user = User.invite_user(Current.user,params[:user][:email])
    respond_to do |format|
      if @user.nil?
        flash.now[:danger] = "Failed to send invitation to #{params[:user][:email]}."
        format.html { render :new }
        format.js { render :new } #TODO: create template error.js.erb to handel errors if any.
      else
        if @user.save
          flash[:success] = "Invitation sent to #{@user.email}!"
          format.html { redirect_to admin_users_path }
          format.js { }
          UserMailer.with(user: @user).invitation_email.deliver_later
        else
          flash.now[:danger] = "Failed to send invitation to #{params[:user][:email]}."
          format.html { render :new }
          format.js { render :new } #TODO: create template error.js.erb to handel errors if any. Add status as well.
        end
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      flash[:danger] = "User has been successfully deleted."
      format.html { redirect_to admin_users_path }
      format.js
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
