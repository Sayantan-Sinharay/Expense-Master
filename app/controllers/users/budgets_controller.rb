# frozen_string_literal: true

module Users
  # Controller for managing budgets for users.
  class BudgetsController < ApplicationController
    before_action :set_budget, only: %i[create]

    def index
      @budgets = Current.user.budgets.order(created_at: :desc)
    end

    def new
      @budget = Budget.new
    end

    def create
      if @budget.valid?
        initialize_budget(wallet)
      else
        handle_invalid_wallet(@wallet)
      end
    end

    private

    def budget_params
      params.require(:budget).permit(:category_id, :amount, :notes, :month)
    end

    def set_wallet
      @wallet = Wallet.at_month(@budget.month).first
    end

    def set_budget_and_wallet
      @budget = Current.user.budgets.new(budget_params)
      set_subcategory
      @wallet = Wallet.at_month(Current.user, @budget.month).first
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
    def handle_invalid_wallet
      flash.now[:danger] =
        @wallet.present? ? 'Please decrease the amount and try again.' : 'Please add some money to the wallet.'
      render :new
    end
  end
end
