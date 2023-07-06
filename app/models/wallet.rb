class Wallet < ApplicationRecord
  belongs_to :user
  validates :amount_given, numericality: { greater_than_or_equal_to: 0 }
  validates :month, presence: true
end
