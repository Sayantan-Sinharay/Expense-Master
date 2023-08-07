# frozen_string_literal: true

module Users
  # Controller for managing budgets for users.
  class BudgetsController < ApplicationController
    before_action :set_budget, only: %i[create]

    def index
      @budgets = Current.user.budgets.order(month: :asc)
    end

    def new
      @budget = Budget.new
    end

    def create
      if @budget.valid?
        initialize_budget(wallet)
      else
        flash.now[:danger] = 'Budget could not be created.'
        render :new
      end
    end

    private

    def budget_params
      params.require(:budget).permit(:category_id, :amount, :notes, :month)
    end

    def set_budget
      @budget = Current.user.budgets.new(budget_params)
    end

    # Sets the subcategory based on the parameters.
    def set_subcategory
      subcategory_id = params[:subcategory_id] == '0' ? nil : params[:subcategory_id]
      @budget.update(subcategory_id:)
    end

    def handle_valid_budget(wallet)
      if wallet.present? && wallet.amount >= @budget.amount && @budget.save
        update_wallet_and_redirect(wallet, 'Budget created successfully.')
      else
        handle_invalid_wallet(wallet)
      end
    end

    # Checks if wallet is valid for budget creation.
    def valid_wallet?(wallet)
      wallet.present? && wallet[:amount] >= @budget.amount && @budget.save
    end

    # Handles invalid wallet for budget creation.
    def handle_invalid_wallet(wallet)
      flash.now[:danger] =
        wallet.present? ? 'Please decrease the amount and try again.' : 'Please add some money to the wallet.'
      render :new
    end

    def update_wallet_and_redirect(wallet, success_message)
      wallet.update(amount: wallet.amount - @budget.amount)
      redirect_to budgets_path, success: success_message
    end
  end
end
