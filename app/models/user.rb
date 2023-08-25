# frozen_string_literal: true

# Represents the user model in the application.
class User < ApplicationRecord
  has_secure_password

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[[:^alnum:]])/x

  belongs_to :organization, inverse_of: :users
  has_many :budgets, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :wallets, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :first_name, presence: { message: 'User must have a first name' },
                         format: { with: /\A[a-zA-Z\s.']+\z/, message: 'First name is invalid' },
                         length: { maximum: 20, message: 'First name is too long.' }
  validates :last_name, length: { maximum: 20, message: 'Last name is too long.' },
                        format: { with: /\A[a-zA-Z\s.']+\z/, message: 'Last name is invalid' }
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
    password = PasswordGenerator.generate_password
    user.update(first_name: 'First Name',
                last_name: 'Last Name',
                password:,
                password_confirmation: password,
                invitation_sent_at: Time.now)
    user
  end

  # A class that is used to generate a password
  class PasswordGenerator
    SYMBOLS = ('!'..'~').to_a.select { |c| c.match?(/\p{S}/) }
    LOWERCASE_LETTERS = ('a'..'z').to_a
    UPPERCASE_LETTERS = ('A'..'Z').to_a
    NUMBERS = ('0'..'9').to_a

    def self.generate_password
      initial_chars = initial_characters
      remaining_chars = remaining_characters(initial_chars)
      shuffle_characters(initial_chars + remaining_chars)
    end

    def self.initial_characters
      [SYMBOLS, LOWERCASE_LETTERS, UPPERCASE_LETTERS, NUMBERS].map(&:sample).join
    end

    def self.remaining_characters(initial_chars)
      total_remaining_chars = SYMBOLS + LOWERCASE_LETTERS + UPPERCASE_LETTERS + NUMBERS
      remaining_chars = (total_remaining_chars - initial_chars.chars).shuffle
      remaining_chars.sample(8 - initial_chars.length).join
    end

    def self.shuffle_characters(password)
      password.chars.shuffle.join
    end
  end
end
