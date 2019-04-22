require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:order) }
  it { should belong_to(:product) }
  it { should validate_presence_of(:quantity) }
end
