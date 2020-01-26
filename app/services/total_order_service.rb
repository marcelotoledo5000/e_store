# frozen_string_literal: true

module TotalOrderService
  def self.execute(order)
    subtotal = order.items.reduce(0) do |value, item|
      value + (item.product[:price] * item.quantity)
    end

    (subtotal + order.freight).round(2)
  end
end
