# frozen_string_literal: true

# Represents the user model in the application.
class User < ApplicationRecord
  has_secure_password

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[[:^alnum:]])/x

  belongs_to :organization
  has_many :budgets, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :wallets, dependent: :destroy
  has_many :notifications, dependent: :destroy


  validates :first_name, presence: { message: 'User must have a first name' },
                         length: { maximum: 20, message: 'First name is too long.' }
  validates :last_name, length: { maximum: 20, message: 'Last name is too long.' }
  validates :email, presence: { message: 'User must have an email' },
                    uniqueness: { case_sensitive: false, message: 'Has already been taken' },
                    format: { with: EMAIL_REGEX, message: 'Is not a valid email format' }
  validates :password, presence: { message: "Can't be blank" },
                       length: { minimum: 8, message: 'Is too short (minimum is 8 characters)' },
                       format: {
                         with: PASSWORD_REGEX,
                         message: 'Must include at least one lowercase letter, one uppercase letter, one digit' \
                         ', and one special character'
                       }
  validates :password_confirmation, presence: { message: "Can't be blank" }, if: -> { password.present? }

  scope :get_non_admin_users, lambda { |organization_id|
    where(organization_id:, is_admin?: false)
  }

  scope :get_admin_users, lambda { |organization_id|
    where(organization_id:, is_admin?: true)
  }

  scope :year_wise_expenses, lambda { |user|
    joins(:expenses)
      .where(expenses: { user:, status: 'approved' })
      .group('expenses.year')
      .sum('expenses.amount')
  }

  scope :category_wise_expenses, lambda { |user|
    joins(:expenses)
      .where(expenses: { user:, status: 'approved' })
      .group('expenses.category_id')
      .sum('expenses.amount')
  }

  # Creates and returns a new user instance with a generated name and password.
  def self.invite_user(admin_user, email)
    password = generate_password
    user = User.new(first_name: "user#{User.last.id}",
                    last_name: admin_user.organization.name,
                    email:,
                    organization_id: admin_user.organization_id,
                    password:,
                    password_confirmation: password)
    invite_user(admin_user, email) unless user.valid?
    user if user.valid?
  end

  # Will generate a password that will match the REGEX
  def self.generate_password
    password = SecureRandom.urlsafe_base64(12)
    password = SecureRandom.urlsafe_base64(12) until password.match?(PASSWORD_REGEX)
    password
  end
end
