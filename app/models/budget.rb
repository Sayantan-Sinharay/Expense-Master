# frozen_string_literal: true

# Represents the budget model in the application.
class Budget < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :subcategory, optional: true

  validates :category, presence: { message: "Category must be selected" }
  validates :amount, presence: { message: "Amount can't be blank" },
                     numericality: { greater_than_or_equal_to: 0, message: "Amount must be greater than or equal to 0" }
  validates :notes, length: { maximum: 255 }
  validates :month, presence: { message: "Month must be selected" }
end
