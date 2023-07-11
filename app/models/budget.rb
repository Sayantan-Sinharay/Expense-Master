class Budget < ApplicationRecord
  belongs_to :user

  validates :category, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :notes, length: { maximum: 255 }
  validates :month, presence: true

  # scope :
end
