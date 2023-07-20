# frozen_string_literal: true

class User::UsersController < ApplicationController
  def index
    redirect_to budgets_path
  end
end
