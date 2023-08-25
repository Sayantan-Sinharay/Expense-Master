# frozen_string_literal: true

# Represents the category model in the application.
class Category < ApplicationRecord
  belongs_to :organization
  has_many :subcategories, dependent: :destroy, inverse_of: :category
  has_many :budgets, dependent: :destroy
  has_many :expenses, dependent: :destroy

  validates :name, presence: { message: "Category name can't be blank" },
                   format: { with: /\A[a-zA-Z\s'\-,&]+\z/, message: 'Category name is invalid' },
                   uniqueness: { scope: :organization_id,
                                 case_sensitive: true,
                                 message: 'Category name must be unique' },
                   length: { in: 2..50, message: 'Category name must be between 2 and 50 characters' }
end
