# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Beer.name }
    description { Faker::Beer.style }
    stock { Faker::Number.between(from: 20, to: 100) }
    price { Faker::Commerce.price(range: 10..99.9, as_string: true) }
    custom_attributes { Faker::ChuckNorris.fact }
  end
end
