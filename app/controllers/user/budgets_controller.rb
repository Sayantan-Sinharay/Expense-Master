class User::BudgetsController < ApplicationController
  layout "user"

  def index
    @budgets = Budget.all
  end

  def new
    @budget = Budget.new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
