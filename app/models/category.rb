# frozen_string_literal: true

# Represents the category model in the application.
class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy
  has_many :budgets
  has_many :expenses

  validates :name, presence: { message: "Category name can't be blank" },
                   uniqueness: { case_sensitive: true, message: 'Category name must be unique' },
                   length: { minimum: 5, maximum: 50, message: 'Category name must be between 5 and 50 characters' }
end
