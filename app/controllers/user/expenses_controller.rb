class User::ExpensesController < ApplicationController
  layout "user"

  def index
    @expenses = Expense.expenses_created_by(Current.user)
  end

  def new
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

  def approve
  end

  def reject
  end
end
