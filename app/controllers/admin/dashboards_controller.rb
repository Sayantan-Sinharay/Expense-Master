# frozen_string_literal: true

module Admin
  # Controller for managing dashboards in the admin panel.
  class DashboardsController < ApplicationController
    include Admin::DashboardsHelper

    def index
      @expenses = Expense.order(created_at: :desc).all
    end

    def approve
      @expense = find_expense
      @expense.update(status: 'approved')
      send_approve_notification(Current.user, @expense)
      redirect_to admin_dashboards_path, success: 'Expense approved successfully.'
    end

    def reject
      @expense = find_expense
      @expense.update(status: 'rejected')
      send_reject_notification(Current.user, @expense)
      redirect_to admin_dashboards_path, danger: 'Expense rejected successfully.'
    end

    private

    def find_expense
      Expense.find(params[:id])
    end
  end
end
