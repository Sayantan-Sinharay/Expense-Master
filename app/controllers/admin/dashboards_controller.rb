class Admin::DashboardsController < ApplicationController
  def index
    @expenses = Expense.order(created_at: :desc).all
  end

  def approve
    @expense = find_expense
    @expense.update(status: "approved")
    redirect_to admin_dashboards_path, success: "Expense approved successfully."
  end

  def reject
    @expense = find_expenses
    expense.update(status: "rejected")
    redirect_to admin_dashboards_path, danger: "Expense rejected successfully."
  end

  private

  def find_expense
    Expense.find(params[:id])
  end
end
