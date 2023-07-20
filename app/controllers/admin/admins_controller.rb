class Admin::AdminsController < ApplicationController
  def index
    redirect_to admin_dashboards_path
  end
end
