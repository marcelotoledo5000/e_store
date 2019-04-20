class Customer < ApplicationRecord
  validates :name, :cpf, :email, :birthday, presence: true
end
