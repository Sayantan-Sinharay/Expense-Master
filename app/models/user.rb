# frozen_string_literal: true

require 'securerandom'

# Represents the user model in the application.
class User < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[[:^alnum:]])/x

  has_secure_password

  belongs_to :organization, inverse_of: :users
  has_many :budgets, dependent: :destroy, inverse_of: :user
  has_many :expenses, dependent: :destroy, inverse_of: :user
  has_many :wallets, dependent: :destroy, inverse_of: :user
  has_many :notifications, dependent: :destroy, inverse_of: :user

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
    password = User.generate_password
    user.update(first_name: 'First Name',
                last_name: 'Last Name',
                password:,
                password_confirmation: password,
                invitation_sent_at: Time.now)
    user
  end

  # Generates a random password with at least one uppercase, one lowercase, one digit, and one symbol.
  def self.generate_password(length = 12)
    required_characters = [
      ('A'..'Z').to_a.sample,
      ('a'..'z').to_a.sample,
      ('0'..'9').to_a.sample,
      ['!', '@', '#', '$', '%', '^', '&', '*'].sample
    ]

    remaining_length = length - required_characters.length

    random_characters = generate_random_characters(remaining_length)

    (required_characters + random_characters).shuffle.join
  end

  # Generates random characters of the specified length.
  def self.generate_random_characters(length)
    available_characters = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a + ['!', '@', '#', '$', '%', '^', '&',
                                                                                  '*']

    SecureRandom.random_bytes(length).each_byte.map do |byte|
      available_characters[byte % available_characters.length]
    end
  end
end
