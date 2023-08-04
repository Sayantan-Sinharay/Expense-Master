# spec/factories/budgets.rb
FactoryBot.define do
  factory :budget do
    association :user
    association :category
    amount { Faker::Number.decimal(l_digits: 2) }
    notes { Faker::Lorem.sentence }
    month { Faker::Date.backward(months: 3).month }
  end
end
