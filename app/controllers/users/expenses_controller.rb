# frozen_string_literal: true

module Users
  # Controller for managing expenses for users.
  class ExpensesController < ApplicationController
    before_action :set_expense, only: %i[create]
    include Users::ExpensesHelper

    def index
      @expenses = Current.user.expenses.order(date: :asc)
    end

    def new
      @expense = Expense.new
    end

    def create
      if @expense.valid?
        handle_valid_expense
      else
        handle_invalid_expense
      end
    end

    private

    def set_expense
      @expense = Current.user.expenses.new(expense_params)
    end

    def expense_params
      params.require(:expense).permit(:category_id, :amount, :attachment, :notes, :date, :subcategory_id)
    end

    def handle_valid_expense
      process_valid_expense
      save_and_notify_expense
    end

    def handle_invalid_expense
      flash.now[:danger] = 'Expense could not be created.'
      render :new
    end

    def process_valid_expense
      attachment = params[:expense][:attachment]
      @expense.attachment.attach(attachment)
      set_subcategory
    end

    def set_subcategory
      subcategory_id = params[:expense][:subcategory_id] == '0' ? nil : params[:expense][:subcategory_id]
      @expense.update(subcategory_id:)
    end

    def save_and_notify_expense
      if @expense.save
        send_notifications(Current.user, @expense)
        flash[:success] = 'Expense created successfully.'
        redirect_to expenses_path
      else
        render :new
      end
    end
  end
end
