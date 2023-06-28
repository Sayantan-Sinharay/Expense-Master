class Organization < ApplicationRecord
  has_many :users
  # validates :name, presence: true, uniqueness: true, length: { minimum: 10 }
end
