# frozen_string_literal: true

# Represents the wallet model in the application.
class Wallet < ApplicationRecord
  belongs_to :user, inverse_of: :wallets

  validates :amount, presence: { message: "Amount can't be blank" },
                     numericality: { greater_than: 0, message: 'Amount must be greater than 0' }
  validates :month, presence: { message: "Month can't be blank" },
                    uniqueness: { scope: %i[user_id year], message: 'Wallet for this month already exists' }

  scope :current_year, lambda {
    where(year: Date.current.year)
  }
  scope :at_month, lambda { |user, month|
    joins(:user)
      .where(users: { id: user.id })
      .where(month:)
  }

  def self.total_amount_for_current_year(user)
    current_year.where(user_id: user[:id]).sum(:amount)
  end
end
