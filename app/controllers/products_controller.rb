class ProductsController < ApplicationController
  def create
    @product = Product.create!(product_params)

    json_response(@product, :created)
  end

  private

  def product_params
    params.permit(:name, :description, :stock, :price, :custom_attributes)
  end
end
