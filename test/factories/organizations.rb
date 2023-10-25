# frozen_string_literal: true

FactoryBot.define do
  factory :organization do
    name { Faker::Company.name }
    subdomain { Faker::Internet.unique.slug }
    email { Faker::Internet.unique.email }
    address { Faker::Address.full_address }
  end
end
