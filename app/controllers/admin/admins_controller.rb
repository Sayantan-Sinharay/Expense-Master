class Admin::AdminsController < ApplicationController
  def index
    redirect_to admin_users_path
  end
end
