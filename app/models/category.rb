# frozen_string_literal: true

# Represents the category model in the application.
class Category < ApplicationRecord
  belongs_to :organization
  has_many :subcategories, dependent: :destroy
  has_many :budgets, dependent: :destroy
  has_many :expenses, dependent: :destroy

  validates :name, presence: { message: "Category name can't be blank" },
                   uniqueness: { scope: :organization_id,
                                 case_sensitive: true,
                                 message: 'Category name must be unique' },
                   length: { minimum: 5, maximum: 50, message: 'Category name must be between 5 and 50 characters' }
end
