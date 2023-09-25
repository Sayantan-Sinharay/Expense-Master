# frozen_string_literal: true

# Represents the Expense model in the application.
class Expense < ApplicationRecord
  has_one_attached :attachment
  belongs_to :user, inverse_of: :expenses
  belongs_to :category, optional: true, inverse_of: :expenses
  belongs_to :subcategory, optional: true, inverse_of: :expenses

  validates :category, presence: { message: 'Category must be selected' }
  validates :date, presence: { message: "Date can't be blank" }
  validates :amount, presence: { message: "Amount can't be blank" },
                     numericality: { greater_than: 0, message: 'Amount must be greater than 0' }
  validates :notes, length: { maximum: 255, message: 'Please give a brief note (maximum is 255 characters)' }
  validate :valid_attachment_content_type, if: :attachment_attached?
  validate :valid_reason, if: -> { status == 'rejected' }, on: :update

  enum status: { pending: 0, approved: 1, rejected: 2 }

  before_validation :extract_month_and_year_from_date, if: :date_present_and_valid?

  scope :get_approved_expenses, lambda { |user|
    joins(:user).where(expenses: { user_id: user.id, status: 'approved' })
  }
  scope :expense_at_organization, lambda { |organization|
    joins(:user).where(users: { organization_id: organization.id })
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

  def valid_reason
    if rejection_reason.blank?
      errors.add(:rejection_reason, 'Rejection reason cannot be blank')
    elsif rejection_reason.length > 255
      errors.add(:rejection_reason, 'Rejection reason should be brief')
    end
  end
end
