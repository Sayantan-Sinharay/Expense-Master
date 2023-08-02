# frozen_string_literal: true

# Represents the expense model in the application.
class Expense < ApplicationRecord
  has_one_attached :attachment
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory

  validates :category, presence: true
  validates :date, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :notes, length: { maximum: 255 }
  validates :status, presence: true

  enum status: { pending: 0, approved: 1, rejected: 2 }

  scope :get_approved_expenses, lambda { |user|
    joins(:user).where(expenses: { user_id: user.id, status: "approved" })
  }
end
