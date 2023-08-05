# frozen_string_literal: true

# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'Password#123' }
    password_confirmation { 'Password#123' }
    organization
  end
end
