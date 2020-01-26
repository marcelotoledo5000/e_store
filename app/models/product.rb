# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, :description, :stock, :price, :custom_attributes,
            presence: true
end
