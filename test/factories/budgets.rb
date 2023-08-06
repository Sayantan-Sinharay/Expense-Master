# frozen_string_literal: true

FactoryBot.define do
  factory :budget do
    association :user
    association :category
    association :subcategory
    amount { Faker::Number.decimal(l_digits: 2) }
    notes { Faker::Lorem.sentence }
    month { Faker::Date.backward(days: 90).month }
  end
end
