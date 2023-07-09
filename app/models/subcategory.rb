class Subcategory < ApplicationRecord
  belongs_to :category
  validates :name, presence: true, uniqueness: { case_sensitive: true }
end
