# frozen_string_literal: true

class OrdersController < ApplicationController
  # POST /orders
  def create
    @order = OrderFactory.execute(order_params)

    json_response(@order, :created)
  end

  # GET /orders
  def index
    @orders = Order.order(:created_at).page params[:page]

    json_response(@orders)
  end

  private

  def order_params
    params.permit(:customer_id, :freight, items: %i[product_id quantity])
  end
end
