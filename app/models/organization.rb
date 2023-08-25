# frozen_string_literal: true

# Represents the organization model in the application.
class Organization < ApplicationRecord
  has_many :users, dependent: :destroy, inverse_of: :organization
  has_many :categories, dependent: :destroy

  validates :name, presence: { message: "Organization name can't be blank" },
                   format: { with: /\A[a-zA-Z\s'\-,&]+\z/, message: 'Organization name is invalid' },
                   uniqueness: { message: 'Organization name must be unique' },
                   length: { in: 2..50, message: 'Organization name must be between 2 and 50 characters' }
end
