# frozen_string_literal: true

class ReportsController < ApplicationController
  # GET: /reports/average_ticket
  def average_ticket
    @average_ticket = AverageTicketService.execute(period_params)

    json_response(@average_ticket)
  end

  private

  def period_params
    params.permit(:initial_date, :final_date)
  end
end
