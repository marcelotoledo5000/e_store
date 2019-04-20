class ProductsController < ApplicationController
  # POST /products
  def create
    @product = Product.create!(product_params)

    json_response(@product, :created)
  end

  # GET /products
  def index
    @products = Product.order(:name).page params[:page]

    json_response(@products)
  end

  # GET /products/:id
  def show
    @product = Product.find(params[:id])

    json_response(@product)
  end

  # PUT /products/:id
  def update
    @product = Product.find(params[:id])
    @product.update(product_params)

    json_response(@product, :created)
  end

  private

  def product_params
    params.permit(:name, :description, :stock, :price, :custom_attributes)
  end
end
