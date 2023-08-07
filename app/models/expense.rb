# frozen_string_literal: true

# Represents the expense model in the application.
class Expense < ApplicationRecord
  has_one_attached :attachment
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :subcategory, optional: true

  validates :category, presence: { message: 'Category must be selected' }
  validates :date, presence: { message: "Date can't be blank" }
  validates :amount, presence: { message: "Amount can't be blank" },
                     numericality: { greater_than_or_equal_to: 0, message: 'Amount must be greater than or equal to 0' }
  validates :notes, length: { maximum: 255 }
  validate :valid_attachment_content_type, if: :attachment_attached?

  enum status: { pending: 0, approved: 1, rejected: 2 }

  before_validation :extract_month_and_year_from_date, if: :date_present_and_valid?

  scope :get_approved_expenses, lambda { |user|
    joins(:user).where(expenses: { user_id: user.id, status: 'approved' })
  }

  private

  def date_present_and_valid?
    date.present? && date.is_a?(Date)
  end

  def extract_month_and_year_from_date
    self.month = date.month
    self.year = date.year
  end

  def attachment_attached?
    attachment.attached?
  end

  def valid_attachment_content_type
    return unless attachment.attached? && !attachment.content_type.in?(%w[image/jpeg image/png application/pdf])
    errors.add(:attachment, 'Attachment content type is invalid')
  end
end
