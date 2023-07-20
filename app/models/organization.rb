# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { minimum: 1 }
end
