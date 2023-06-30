class Admin::UsersController < ApplicationController
  def index
    @users = User.non_admins_by_organization(Current.user.organization_id)
  end

  def new
  end

  def create
  end

  def destroy
  end
end
