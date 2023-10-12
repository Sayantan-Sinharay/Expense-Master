# frozen_string_literal: true

# spec/factories/categories.rb
FactoryBot.define do
  factory :category do
    name { Faker::Commerce.department }
    association :organization
  end
end
