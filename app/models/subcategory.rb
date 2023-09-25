# frozen_string_literal: true

# Represents the subcategory model in the application.
class Subcategory < ApplicationRecord
  belongs_to :category, inverse_of: :subcategories
  has_many :budgets, dependent: :nullify
  has_many :expenses, dependent: :nullify

  validates :name, presence: { message: "Subcategory name can't be blank" },
                   format: { with: /\A[a-zA-Z\s'\-,&]+\z/, message: 'Subcategory name is invalid' },
                   uniqueness: { scope: :category_id,
                                 case_sensitive: true,
                                 message: 'Subcategory name must be unique within the same category' },
                   length: { in: 2..50, message: 'Subcategory name must be between 2 and 50 characters' }
end
