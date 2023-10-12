# frozen_string_literal: true

module Users
  # Controller for managing users in the user panel.
  class UsersController < ApplicationController
    before_action :require_login
    before_action :authenticate_user

    def index
      redirect_to budgets_path
    end
  end
end
