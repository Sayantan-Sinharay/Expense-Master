class HomesController < ApplicationController
  def index
    if Current.user
      if Current.user.is_admin?
        redirect_to admin_index_path, notice: "welcome admin"
      else
        redirect_to index_path, notice: "Welcome user"
      end
    else
      redirect_to login_path
    end
  end

  def new
  end
end
