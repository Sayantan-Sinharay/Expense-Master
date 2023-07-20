# frozen_string_literal: true

module Users
  # Controller for managing users in the user panel.
  class UsersController < ApplicationController
    def index
      redirect_to budgets_path
    end
  end
end
