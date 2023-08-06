# frozen_string_literal: true

# Represents the mailer for user-related emails.
class UserMailer < ApplicationMailer
  def invitation_email
    @user = params[:user]
    @token = params[:user].signed_id(purpose: 'invitation', expires_in: 24.hours)
    @title = 'Welcome to Expense Master Application!'

    mail(to: @user.email, subject: 'Invitation to Expense Master Application')
  end

  def confirmation_email
    @user = params[:user]
    @title = 'Welcome to Expense Master Application!'

    mail(to: @user.email, subject: 'Signup Confirmation - Expense Master')
  end

  def request_expense_approval_email
    @admin = params[:admin]
    @expense = params[:expense]
    @user = @expense.user
    @title = 'Expense Approval Required!'

    mail(to: @admin.email, subject: 'Expense Approval Required - Expense Master')
  end

  def expense_status_update_email
    @admin = params[:admin]
    @expense = params[:expense]
    @user = @expense.user
    @title = "Your Expense is #{@expense.status.humanize}!"

    mail(to: @user.email, subject: "Expense #{@expense.status.humanize} - Expense Master")
  end

  def monthly_expense_report
    @user = params[:user]
    @title = 'Your Monthly Expense Report'
    attachments[params[:pdf_filename].to_s] = File.read(params[:pdf_filename])
    mail(to: @user.email, subject: 'Monthly Expense Report')
  end
end
