# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :customer
  has_many :items, dependent: :destroy

  validates :freight, presence: true

  enum status: { received: 0, approved: 1, delivered: 2, canceled: 3 }
end
