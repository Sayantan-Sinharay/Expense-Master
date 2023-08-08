# frozen_string_literal: true

# spec/factories/categories.rb
FactoryBot.define do
  factory :category do
    name { Faker::Lorem.characters(number: rand(5..50)) }
    association :organization
  end
end
