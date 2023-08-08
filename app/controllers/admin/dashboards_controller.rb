# frozen_string_literal: true

module Admin
  # Controller for managing dashboards in the admin panel.
  class DashboardsController < ApplicationController
    before_action :authenticate_admin
    before_action :find_expense, only: %i[approve reject]
    include Admin::DashboardsHelper

    def index
      @expenses = Expense.order(created_at: :desc).all
    end

    def approve
      @expense.update(status: 'approved')
      send_expense_status_update_notification(Current.user, @expense)
      redirect_to admin_dashboards_path, success: 'Expense approved successfully.'
    end

    def reject
      if validate_reason?
        handel_valid_reason
      else
        handel_invalid_reason
      end
    end

    private

    # Finds an expense based on the ID parameter.
    def find_expense
      @expense = Expense.find(params[:id])
    end

    def validate_reason?
      if params[:expense][:rejection_reason].blank?
        @expense.errors.add(:rejection_reason, 'Rejection reason cannot be blank')
      elsif params[:expense][:rejection_reason].length > 255
        @expense.errors.add(:rejection_reason, 'Rejection reason should be brief')
      else
        return true
      end
      false
    end

    def handel_valid_reason
      @expense.update(status: 'rejected', rejection_reason: params[:expense][:rejection_reason])
      send_expense_status_update_notification(Current.user, @expense)
      redirect_to admin_dashboards_path, danger: 'Expense rejected successfully.'
    end

    def handel_invalid_reason
      render :reject
    end

    def validate_reason?
      if params[:expense][:rejection_reason].blank?
        @expense.errors.add(:rejection_reason, "Rejection reason cannot be blank") 
      elsif params[:expense][:rejection_reason].length > 255
        @expense.errors.add(:rejection_reason, "Rejection reason should be brief")
      else
        return true
      end
      return false
    end

    def handel_valid_reason
      @expense.update(status: 'rejected', rejection_reason: params[:expense][:rejection_reason])
      send_expense_status_update_notification(Current.user, @expense)
      redirect_to admin_dashboards_path, danger: 'Expense rejected successfully.'
    end

    def handel_invalid_reason
      render :reject
    end

  end
end
