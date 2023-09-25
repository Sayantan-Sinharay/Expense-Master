# frozen_string_literal: true

# Represents the budget model in the application.
class Budget < ApplicationRecord
  belongs_to :user, inverse_of: :budgets
  belongs_to :category, optional: true
  belongs_to :subcategory, optional: true

  validates :category, presence: { message: 'Category must be selected' }
  validates :amount, presence: { message: "Amount can't be blank" },
                     numericality: { greater_than: 0, message: 'Amount must be greater than 0' }
  validates :notes, length: { maximum: 255, message: 'Please give a brief note (maximum is 255 characters)' }
  validates :month, presence: { message: 'Month must be selected' },
                    inclusion: { in: 1..12, message: 'Month must be between 1 and 12' }
end
