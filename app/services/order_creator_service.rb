module OrderCreatorService
  def self.execute(order_params)
    parsed_items = []
    order_params[:items].each do |item|
      parsed_items << Item.new(item)
    end

    order = Order.new(customer_id: order_params[:customer_id],
                      freight: order_params[:freight],
                      items: parsed_items)
    order.save!

    order
  end
end
