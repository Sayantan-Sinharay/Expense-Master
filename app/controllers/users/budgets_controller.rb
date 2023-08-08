# frozen_string_literal: true

module Users
  # Controller for managing budgets for users.
  class BudgetsController < ApplicationController
    before_action :authenticate_user
    before_action :set_budget_and_wallet, only: :create

    def index
      @budgets = Current.user.budgets.order(created_at: :desc)
    end

    def new
      @budget = Budget.new
    end

    def create

      if @budget.valid?
        if valid_wallet?
          handle_valid_budget
        else
          handle_invalid_wallet
        end

      else
        flash.now[:danger] = 'Budget could not be created.'
        render :new
      end
    end

    private

    def budget_params
      params.require(:budget).permit(:category_id, :amount, :notes, :month)
    end

    def set_budget_and_wallet
      @budget = Current.user.budgets.new(budget_params)
      set_subcategory
      @wallet = Wallet.at_month(@budget.month).first
    end

    # Sets the subcategory based on the parameters.
    def set_subcategory
      subcategory_id = params[:budget][:subcategory_id].to_i.zero? ? nil : params[:budget][:subcategory_id]
      @budget.subcategory_id = subcategory_id

    end

    def handle_valid_budget
      @wallet.update(amount: @wallet.amount - @budget.amount)
      if @budget.save
        redirect_to budgets_path, success: 'Budget created successfully.'
      else
        render :new
      end
    end

    # Checks if wallet is valid for budget creation.
    def valid_wallet?
      @wallet.present? && @wallet.amount >= @budget.amount
    end
    # Handles invalid wallet for budget creation.
    def handle_invalid_wallet

      flash.now[:danger] =
        @wallet.present? ? 'Please decrease the amount and try again.' : 'Please add some money to the wallet.'
      render :new
    end
  end
end
