# frozen_string_literal: true

# Represents the category model in the application.
class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy
  belongs_to :budgets
  belongs_to :expenses
  validates :name, presence: true, uniqueness: { case_sensitive: true }
end
