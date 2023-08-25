# frozen_string_literal: true

# spec/factories/subcategories.rb
FactoryBot.define do
  factory :subcategory do
    name { Faker::Lorem.words(number: rand(2..5)).join(' ') }
    association :category
  end
end
