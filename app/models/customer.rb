# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :name, :cpf, :email, :birthday, presence: true
end
