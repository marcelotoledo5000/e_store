class CustomersController < ApplicationController
  # POST /customers
  def create
    @customer = Customer.create!(customer_params)

    json_response(@customer, :created)
  end

  private

  def customer_params
    params.permit(:name, :cpf, :email, :birthday)
  end
end
