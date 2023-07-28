# frozen_string_literal: true

# Represents the mailer for user-related emails.
class UserMailer < ApplicationMailer
  def invitation_email
    @user = params[:user]
    @token = params[:user].signed_id(purpose: 'invitation', expires_in: 24.hours)
    @title = "Welcome to Expense Master Application!"

    mail(to: @user.email, subject: 'Invitation to Expense Master Application')
  end
  
  def confirmation_email
    @user = params[:user]
    @title = "Welcome to Expense Master Application!"

    mail(to: @user.email, subject: "Signup Confirmation - Expense Master")
  end 

  def request_approval_email
    @admin = params[:admin]
    @expense = params[:expense]
    @user = @expense.user
    @title = "Expense Approval Required!"

    mail(to: @admin.email, subject: "Expense Approval Required - Expense Master")
  end

  def expense_status_update_email
    @admin = params[:admin]
    @expense = params[:expense]
    @user = @expense.user
    
    if (@expense.status == "approved")
      @title = "Your Expense is Approved!"
    else 
      @title = "Your Expense is Rejected!"
    end
    
    mail(to: @user.email, subject: "Expense Approval - Expense Master")
  end 
end
