module ValidateStockService
  def self.execute(order_params)
    parsed_items = []

    order_params[:items].each do |item|
      product = Product.find item[:product_id]

      raise StockIsNotAvailable, 'Stock is not available' unless
        item[:quantity].to_i <= product.stock

      parsed_items << Item.new(item)
      update_stock(product, item)
    end

    parsed_items
  end

  def self.update_stock(product, item)
    product.stock -= item[:quantity].to_i
    product.save!
  end
end
