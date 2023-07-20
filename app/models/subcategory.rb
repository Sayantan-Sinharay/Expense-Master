# frozen_string_literal: true

# Represents the subcategory model in the application.
class Subcategory < ApplicationRecord
  belongs_to :category
  validates :name, presence: true, uniqueness: { case_sensitive: true }
end
