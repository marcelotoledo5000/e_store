class CustomersController < ApplicationController
  # POST /customers
  def create
    @customer = Customer.create!(customer_params)

    json_response(@customer, :created)
  end

  # GET /customers
  def index
    @customers = Customer.order(:name).page params[:page]

    json_response(@customers)
  end

  # GET /customer/:id
  def show
    @customer = Customer.find(params[:id])

    json_response(@customer)
  end

  private

  def customer_params
    params.permit(:name, :cpf, :email, :birthday)
  end
end
