class Expense < ApplicationRecord
  has_one_attachment :attachment
  belongs_to :user

  validates :category, presence: true
  validates :sub_category, presence: true
  validates :date, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :notes, length: { maximum: 255 }
  validates :status, presence: true

  enum status: { pending: 0, approved: 1, rejected: 2 }
end
