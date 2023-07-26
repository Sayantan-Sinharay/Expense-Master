# frozen_string_literal: true

# Represents the mailer for user-related emails.
class UserMailer < ApplicationMailer
  def invitation_email
    @user = params[:user]
    @token = params[:user].signed_id(purpose: 'invitation', expires_in: 24.hours)

    mail(to: @user.email, subject: 'Invitation to Expense Master Application')
  end
  
  def confirmation_email
    @user = params[:user]

    mail(to:@user.email, subject: 'Your Account has been confirmed')
  end 
end
