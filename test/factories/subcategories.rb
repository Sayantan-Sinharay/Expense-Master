# frozen_string_literal: true

# spec/factories/subcategories.rb
FactoryBot.define do
  factory :subcategory do
    name { Faker::Commerce.product_name }
    association :category
  end
end
