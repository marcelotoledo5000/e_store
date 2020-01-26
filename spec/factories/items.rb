# frozen_string_literal: true

FactoryBot.define do
  # item factory with a `belongs_to` association for the order
  factory :item do
    order
    product
    quantity { Faker::Number.between(from: 1, to: 10) }
  end
end
