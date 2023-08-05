# Represents the subcategory model in the application.
class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :budgets
  has_many :expenses

  validates :name, presence: { message: "Subcategory name can't be blank" },
                   uniqueness: { scope: :category_id, case_sensitive: true, message: 'Subcategory name must be unique within the same category' },
                   length: { minimum: 5, maximum: 50, message: 'Subcategory name must be between 5 and 50 characters' }
end
