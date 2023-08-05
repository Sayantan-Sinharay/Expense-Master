# frozen_string_literal: true

# spec/factories/notifications.rb
FactoryBot.define do
  factory :notification do
    association :user
    message { Faker::Lorem.sentence }
    read { false }
  end
end
