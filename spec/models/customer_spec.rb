# frozen_string_literal: true

require 'rails_helper'

describe Customer, type: :model do
  it { is_expected.to have_many(:orders) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:cpf) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:birthday) }
end
