# frozen_string_literal: true

# https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md
# Generating data for a `has_many` relationship

FactoryBot.define do
  # order factory without associated items
  factory :order do
    customer
    status { 'received' }
    freight { Faker::Commerce.price(5..19.9, as_string: true) }

    # order_with_items will create item data after the order has been created
    factory :order_with_items do
      transient do
        items_count { 3 }
      end

      after(:create) do |order, evaluator|
        create_list(:item, evaluator.items_count, order: order)
      end
    end
  end
end
