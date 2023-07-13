class Budget < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory

  validates :category, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :notes, length: { maximum: 255 }
  validates :month, presence: true

  scope :budgets_created_by, ->(user) { where(user_id: user[:id]) }
end
