# frozen_string_literal: true

# spec/factories/subcategories.rb
FactoryBot.define do
  factory :subcategory do
    name { Faker::Lorem.characters(number: rand(5..50)) }
    association :category
  end
end
