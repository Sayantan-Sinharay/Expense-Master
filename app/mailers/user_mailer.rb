# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def invitation_email
    @user = params[:user]
    @token = params[:user].signed_id(purpose: 'invitation', expires_in: 24.hours)

    mail(to: @user.email, subject: '')
  end
end
