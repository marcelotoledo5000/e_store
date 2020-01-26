# frozen_string_literal: true

module AverageTicketService
  def self.execute(period_params)
    orders = selected_orders(period_params)

    average_ticket(orders)
  end

  def self.selected_orders(period_params)
    Order.where(
      created_at: period_params[:initial_date]..period_params[:final_date]
    )
  end

  def self.total_value_of_orders(orders)
    total_value = orders.reduce(0) do |value, order|
      value + TotalOrderService.execute(order)
    end

    total_value.round(2)
  end

  def self.average_ticket(orders)
    (total_value_of_orders(orders) / orders.count).round(2)
  end
end
