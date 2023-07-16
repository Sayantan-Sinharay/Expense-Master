class User::ExpensesController < ApplicationController
  def index
    @expenses = Current.user.expenses.order(date: :asc)
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user = Current.user
    @expense.attachment.attach(params[:expense][:attachment])
    year = @expense[:date].year
    month = @expense[:date].month
    @expense.update(year: year, month: month)
    binding.pry
    if @expense.save
      redirect_to expenses_path, success: "Expense created successfully."
    else
      flash.now[:danger] = "Expense could not be created."
      render :new
    end
  end

  def approve
    @expense = find_expense
    @expense.approved!
    redirect_to expenses_path, success: "Expense approved successfully."
  end

  def reject
    @expense = find_expense
    @expense.rejected!
    redirect_to expenses_path, success: "Expense rejected successfully."
  end

  private

  def find_expense
    Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:category_id, :subcategory_id, :amount, :attachment, :notes, :date)
  end
end
