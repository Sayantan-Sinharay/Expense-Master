# frozen_string_literal: true

# Represents the base mailer class for the application.
class ApplicationMailer < ActionMailer::Base
  default from: 'expense.master.app@gmail.com'
  layout 'mailer'
end
