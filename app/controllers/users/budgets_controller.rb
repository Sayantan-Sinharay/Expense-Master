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
      return render_invalid_budget unless @budget.valid?

      update_budget_attributes
      wallet = Wallet.with_month(@budget.month).first
      handle_valid_budget(wallet)
    end

    private

    def budget_params
      params.require(:budget).permit(:category_id, :amount, :notes, :month)
    end

    def set_budget
      @budget = Current.user.budgets.new(budget_params)
    end

    def update_budget_attributes
      @budget.update(subcategory_id: clear_subcategory_if_invalid)
    end

    def clear_subcategory_if_invalid
      params[:subcategory_id] == '0' ? nil : params[:subcategory_id]
    end

    def handle_valid_budget(wallet)
      if wallet.present? && wallet.amount >= @budget.amount && @budget.save
        update_wallet_and_redirect(wallet, 'Budget created successfully.')
      else
        handle_invalid_wallet(wallet)
      end
    end

    def render_invalid_budget
      flash.now[:danger] = 'Budget could not be created.'
      render :new
    end

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
