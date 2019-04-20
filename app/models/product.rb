class Product < ApplicationRecord
  validates :name, :description, :stock, :price, :custom_attributes,
            presence: true
end
