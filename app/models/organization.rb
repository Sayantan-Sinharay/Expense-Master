# frozen_string_literal: true

# Represents the organization model in the application.
class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { minimum: 1 }
end
