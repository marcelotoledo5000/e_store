# frozen_string_literal: true

require 'rails_helper'

describe Item, type: :model do
  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:product) }
  it { is_expected.to validate_presence_of(:quantity) }
end
