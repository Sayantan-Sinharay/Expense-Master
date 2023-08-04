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
      @expense = Current.user.expenses.new(expense_params)
      
      if @expense.valid?
        process_valid_expense
      else
        flash.now[:danger] = 'Expense could not be created.'
        render :new
      end
    end

    private

    # Permits the expense parameters.
    def expense_params
      params.require(:expense).permit(:category_id, :amount, :attachment, :notes, :date)
    end

    # Processes a valid expense.
    def process_valid_expense
      attachment = params[:expense][:attachment]
      @expense.attachment.attach(attachment)
      update_month_and_year(@expense)
      set_subcategory
      save_and_notify_expense
    end

    # Sets the subcategory based on the parameters.
    def set_subcategory
      subcategory_id = params[:subcategory_id] == '0' ? nil : params[:subcategory_id]
      @expense.update(subcategory_id: subcategory_id)
    end

    # Saves the expense and sends notifications.
    def save_and_notify_expense
      if @expense.save
        send_notifications(Current.user, @expense)
        redirect_to expenses_path, success: 'Expense created successfully.'
      else
        flash.now[:danger] = 'Expense could not be created.'
        render :new
      end
    end
  end
end
