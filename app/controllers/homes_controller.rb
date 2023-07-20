class HomesController < ApplicationController
  def index
    if Current.user
      if Current.user.is_admin?
        redirect_to admin_index_path
      else
        redirect_to index_path
      end
    else
      redirect_to login_path
    end
  end

  def new
  end
end
