class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show update]

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
    json_response(@customer)
  end

  # PUT /customer/:id
  def update
    @customer.update!(customer_params)

    json_response(@customer, :created)
  end

  private

  def customer_params
    params.permit(:name, :cpf, :email, :birthday)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
