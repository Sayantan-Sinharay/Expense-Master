class User::BudgetsController < ApplicationController
  layout "user"

  def index
    @budgets = Budget.budgets_created_by(Current.user)
  end

  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    binding.pry
    if @budget.save
      redirect_to budgets_path, notice: "Budget created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def budget_params
    params.require(:budget).permit(:category_id, :subcategory_id, :amount, :notes, :month)
  end
end
