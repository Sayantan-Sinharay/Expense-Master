# frozen_string_literal: true

module User
  # Controller for managing expenses for users.
  class ExpensesController < ApplicationController
    include User::ExpensesHelper

    def index
      @expenses = Current.user.expenses.order(date: :asc)
    end

    def new
      @expense = Expense.new
    end

    def create
      @expense = Current.user.expenses.new(expense_params)
      @expense.attachment.attach(params[:expense][:attachment])
      update_month_and_year(@expense)

      if @expense.save
        send_notifications(Current.user, @expense)
        redirect_to expenses_path, success: 'Expense created successfully.'
      else
        flash.now[:danger] = 'Expense could not be created.'
        render :new
      end
    end

    private

    def find_expense
      Expense.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(:category_id, :subcategory_id, :amount, :attachment, :notes, :date)
    end
  end
end
