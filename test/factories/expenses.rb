# frozen_string_literal: true

# spec/factories/expenses.rb
FactoryBot.define do
  factory :expense do
    association :user
    association :category
    association :subcategory
    date { Faker::Date.backward(days: 30) }
    amount { Faker::Number.decimal(l_digits: 2) }
    notes { Faker::Lorem.sentence }
    status { :approved }
  end
end
