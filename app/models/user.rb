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
  def self.create_user(user)
    password = generate_password
    user.update(first_name: "user#{User.last.id}",
                last_name: user.organization.name,
                password:,
                password_confirmation: password,
                invitation_sent_at: Time.now)
    user
  end

  # Will generate a password that will match the REGEX
  def self.generate_password
    symbols = ['!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '-', '=', '{', '}', '[', ']', '|', ' :',
               ';', '"', "'", '<', '>', ',', '.', '?', '/']
    lowercase_letters = ('a'..'z').to_a
    uppercase_letters = ('A'..'Z').to_a
    numbers = ('0'..'9').to_a

    password = initial_characters(symbols, lowercase_letters, uppercase_letters, numbers)
    password += remaining_characters(password)
    shuffle_characters(password)
  end

  def self.initial_characters(symbols, lowercase_letters, uppercase_letters, numbers)
    symbols.sample + lowercase_letters.sample + uppercase_letters.sample + numbers.sample
  end

  def self.remaining_characters(password)
    remaining_chars = (symbols + lowercase_letters + uppercase_letters + numbers).shuffle
    remaining_chars.sample(8 - password.length).join
  end

  def self.shuffle_characters(password)
    password.chars.shuffle.join
  end
end
