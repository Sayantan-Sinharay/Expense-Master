# frozen_string_literal: true

# spec/factories/wallets.rb
FactoryBot.define do
  factory :wallet do
    association :user
    amount { Faker::Number.decimal(l_digits: 2) }
    month { Faker::Date.backward(days: 90).month }
  end
end
