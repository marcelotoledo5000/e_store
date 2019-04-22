FactoryBot.define do
  factory :order do
    customer
    freight { Faker::Commerce.price(5..19.9, as_string: true) }
    items do
      [
        Item.new(
          product_id: FactoryBot.create(:product).id,
          quantity: Faker::Number.between(1, 10)
        )
      ]
    end
  end
end
