# frozen_string_literal: true

# Represents the category model in the application.
class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: true }
end
