class Order < ApplicationRecord
  belongs_to :customer
  has_many :items, dependent: :destroy

  validates :freight, presence: true

  enum status: %i[received approved delivered canceled]
end
