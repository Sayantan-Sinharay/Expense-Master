# frozen_string_literal: true

# Represents the expense model in the application.
class Expense < ApplicationRecord
  has_one_attached :attachment
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :subcategory, optional: true

  validates :category, presence: { message: "Category must be selected" }
  validates :date, presence: { message: "Date can't be blank" }
  validates :amount, presence: { message: "Amount can't be blank" },
                     numericality: { greater_than_or_equal_to: 0, message: "Amount must be greater than or equal to 0" }
  validates :notes, length: { maximum: 255 }
  validates :status, presence: { message: "Status can't be blank" }

  enum status: { pending: 0, approved: 1, rejected: 2 }

  scope :get_approved_expenses, lambda { |user|
    joins(:user).where(expenses: { user_id: user.id, status: "approved" })
  }
end
