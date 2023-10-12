# frozen_string_literal: true

PASSWORD = 'Password#123'
# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { PASSWORD }
    password_confirmation { PASSWORD }
    organization
  end
end
