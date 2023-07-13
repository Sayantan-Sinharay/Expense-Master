class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
      log_in(user)
      redirect_to root_path, success: "Successfully logged in"
    else
      flash.now[:danger] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def log_in(user)
    session[:user_id] = user.id
    set_current_user
  end

  def log_out
    reset_session
  end
end
