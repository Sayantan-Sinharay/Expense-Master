# frozen_string_literal: true

module Users
  # Controller for managing expenses for users.
  class ExpensesController < ApplicationController
    include Users::ExpensesHelper

    def index
      @expenses = Current.user.expenses.order(date: :asc)
    end

    def new
      @expense = Expense.new
    end

    def create
      @expense = build_expense_from_params
      if @expense.save
        send_notifications(Current.user, @expense)
        redirect_to expenses_path, success: 'Expense created successfully.'
      else
        flash.now[:danger] = 'Expense could not be created.'
        render :new
      end
    end

    private

    # Build an expense object from the submitted parameters.
    def build_expense_from_params
      expense = Current.user.expenses.new(expense_params)
      attachment = params[:expense][:attachment]
      expense.attachment.attach(attachment)
      update_month_and_year(expense)
      expense
    end

    # Finds an expense based on the ID parameter.
    def find_expense
      Expense.find(params[:id])
    end

    # Permits the expense parameters.
    def expense_params
      params.require(:expense).permit(:category_id, :subcategory_id, :amount, :attachment, :notes, :date)
    end
  end
end
