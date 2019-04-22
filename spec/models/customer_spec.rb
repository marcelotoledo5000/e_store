require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_many(:orders) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cpf) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:birthday) }
end
