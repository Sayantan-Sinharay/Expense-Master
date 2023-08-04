# spec/factories/wallets.rb
FactoryBot.define do
  factory :wallet do
    association :user
    amount { Faker::Number.decimal(l_digits: 2) }
    month { Faker::Date.backward(months: 3).month }
  end
end
