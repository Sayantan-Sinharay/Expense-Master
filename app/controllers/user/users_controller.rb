class User::UsersController < ApplicationController
  layout "user"

  def index
    redirect_to budgets_path
  end
end
