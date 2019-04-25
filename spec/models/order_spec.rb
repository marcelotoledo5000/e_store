require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:customer) }
  it { should have_many(:items).dependent(:destroy) }
  it { should validate_presence_of(:freight) }
  it do
    should define_enum_for(:status).
      with_values(%i[received approved delivered canceled])
  end
end
