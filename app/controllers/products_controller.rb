class ProductsController < ApplicationController
  before_action :set_product, only: %i[destroy show update]

  # POST /products
  def create
    @product = Product.create!(product_params)

    json_response(@product, :created)
  end

  # DELETE /products/:id
  def destroy
    @product.destroy

    head :no_content
  end

  # GET /products
  def index
    @products = Product.order(:name).page params[:page]

    json_response(@products)
  end

  # GET /products/:id
  def show
    json_response(@product)
  end

  # PUT /products/:id
  def update
    @product.update!(product_params)

    json_response(@product, :created)
  end

  private

  def product_params
    params.permit(:name, :description, :stock, :price, :custom_attributes)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
