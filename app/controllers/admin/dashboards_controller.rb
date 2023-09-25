# frozen_string_literal: true

module Admin
  # Controller for managing dashboards in the admin panel.
  class DashboardsController < ApplicationController
    before_action :authenticate_admin
    before_action :find_expense, only: %i[approved reject rejected]

    include Admin::DashboardsHelper
    include NotificationsHelper

    def index
      @expenses = Expense.expense_at_organization(Current.user.organization).order(created_at: :desc)
    end

    def approved
      respond_to do |format|
        if @expense.approved!
          send_expense_status_update_notification(Current.user, @expense)
          flash = { success: 'Expense approved successfully.' }
          send_flash(Current.user, flash)
          format.html { redirect_to admin_dashboards_path }
          format.js
        end
      end
    end

    def reject
      respond_to(&:js)
    end

    def rejected
      respond_to do |format|
        if @expense.update(status: 'rejected', rejection_reason: params[:expense][:rejection_reason])
          handel_valid_reason(format)
        else
          handel_invalid_reason(format)
        end
      end
    end

    private

    def find_expense
      @expense = Expense.find(params[:id])
    end

    def handel_valid_reason(format)
      send_expense_status_update_notification(Current.user, @expense)
      flash = { danger: 'Expense rejected successfully' }
      format.html { redirect_to admin_dashboards_path }
      format.js
    end

    def handel_invalid_reason(format)
      format.js { render :reject }
    end
  end
end
