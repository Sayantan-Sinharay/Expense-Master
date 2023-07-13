class Credit < ApplicationRecord
  belongs_to :user
  belongs_to :beneficiary_user, class_name: "User", foreign_key: "beneficiary_user_id"

  validates :amount_given, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true

  scope :credits_created_by, ->(user) { where(user_id: user[:id]) }
end
