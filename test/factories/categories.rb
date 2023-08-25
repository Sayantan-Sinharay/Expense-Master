# frozen_string_literal: true

# spec/factories/categories.rb
FactoryBot.define do
  factory :category do
    name { Faker::Lorem.words(number: rand(2..5)).join(' ') }
    association :organization
  end
end
