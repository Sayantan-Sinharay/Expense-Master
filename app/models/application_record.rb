# frozen_string_literal: true

# Base class for all application models.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[[:^alnum:]])/
  SUBDOMAIN_REGEX = /\A[a-z0-9_]+(-[a-z0-9_]+)*\z/i
end
