# frozen_string_literal: true

module Users
  # Controller for managing budgets for users.
  class BudgetsController < ApplicationController
    before_action :require_login
    before_action :authenticate_user
    before_action :set_budget_and_wallet, only: :create

    def index
      @budgets = Current.user.budgets.order(created_at: :desc)
    end

    def new
      @budget = Budget.new
    end

    def create
      if valid_budget? && valid_wallet?
        handle_valid_budget
      else
        handle_invalid_budget
      end
    end

    private

    def budget_params
      params.require(:budget).permit(:category_id, :amount, :notes, :month)
    end

    def set_budget_and_wallet
      @budget = Current.user.budgets.new(budget_params)
      set_subcategory
      @wallet = Wallet.at_month(Current.user, @budget.month).first
    end

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

    def valid_budget?
      @budget.valid?
    end

    def valid_wallet?
      @wallet.present? && @wallet.amount >= @budget.amount
    end

    def handle_invalid_budget
      flash.now[:danger] =
        @wallet.present? ? 'Please decrease the amount and try again.' : 'Please add some money to the wallet.'
      render :new
    end
  end
end
