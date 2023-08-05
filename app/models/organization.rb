# frozen_string_literal: true

# Represents the organization model in the application.
class Organization < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :name, presence: { message: "Organization name can't be blank" },
                   uniqueness: { message: 'Organization name must be unique' },
                   length: { minimum: 1, message: "Organization name can't be empty" }
end
