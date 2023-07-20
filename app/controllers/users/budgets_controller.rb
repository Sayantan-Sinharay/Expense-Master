# frozen_string_literal: true

module Users
  # Controller for managing budgets for users.
  class BudgetsController < ApplicationController
    def index
      @budgets = Current.user.budgets.order(month: :asc)
    end

    def new
      @budget = Budget.new
    end

    def create
      @budget = Current.user.budgets.new(budget_params)
      @budget.update(year: Date.current.year)

      if @budget.save
        redirect_to budgets_path, success: 'Budget created successfully.'
      else
        flash.now[:danger] = 'Budget could not be created.'
        render :new
      end
    end

    private

    # Permits the budget parameters.
    def budget_params
      params.require(:budget).permit(:category_id, :subcategory_id, :amount, :notes, :month)
    end
  end
end
