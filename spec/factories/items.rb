# frozen_string_literal: true

FactoryBot.define do
  # item factory with a `belongs_to` association for the order
  factory :item do
    order
    product
    quantity { Faker::Number.between(1, 10) }
  end
end
