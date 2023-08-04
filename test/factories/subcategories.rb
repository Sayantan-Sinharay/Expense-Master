# spec/factories/subcategories.rb
FactoryBot.define do
  factory :subcategory do
    name { Faker::Lorem.word }
    association :category
  end
end
