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
    total_value = 0
    orders.each do |order|
      total_value += TotalOrderService.execute(order)
    end

    total_value
  end

  def self.average_ticket(orders)
    total_value_of_orders(orders) / orders.count
  end
end
