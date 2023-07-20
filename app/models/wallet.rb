# frozen_string_literal: true

# Represents the wallet model in the application.
class Wallet < ApplicationRecord
  belongs_to :user
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :month, presence: true, uniqueness: true

  # Scope to get wallets for the current year.
  scope :current_year, lambda {
                         where(year: Date.current.year)
                       }

  # Returns the total amount in wallets for the current year and given user.
  def self.total_amount_for_current_year(user)
    current_year.where(user_id: user[:id]).sum(:amount)
  end
end
