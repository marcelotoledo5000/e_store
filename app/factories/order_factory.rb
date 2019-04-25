module OrderFactory
  def self.execute(order_params)
    ActiveRecord::Base.transaction do
      parsed_items = ValidateStockService.execute(order_params)

      order = Order.new(customer_id: order_params[:customer_id],
                        freight: order_params[:freight],
                        items: parsed_items)
      order.save!

      order
    end
  end
end
