class Order < ApplicationRecord
  belongs_to :customer
  has_many :items, dependent: :destroy

  validates :freight, :items, presence: true

  enum status: %i[received approved delivered canceled]
end
