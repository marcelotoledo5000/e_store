module TotalOrderService
  def self.execute(order)
    subtotal = 0
    order.items.each do |item|
      subtotal += item.product.price
    end

    subtotal + order.freight
  end
end
