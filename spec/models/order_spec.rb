# frozen_string_literal: true

require 'rails_helper'

describe Order, type: :model do
  subject(:order) { described_class.new }

  it { is_expected.to belong_to(:customer) }
  it { is_expected.to have_many(:items).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:freight) }

  it do
    expect(order).to define_enum_for(:status).
      with_values(%i[received approved delivered canceled])
  end
end
