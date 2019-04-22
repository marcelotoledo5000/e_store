class OrdersController < ApplicationController
  # POST /orders
  def create
    @order = OrderCreatorService.execute(order_params)

    json_response(@order, :created)
  end

  private

  def order_params
    params.permit(:customer_id, :freight, items: %i[product_id quantity])
  end
end
