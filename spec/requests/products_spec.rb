require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'POST /products' do
    let(:name) { Faker::Beer.name }
    let(:description) { Faker::Beer.style }
    let(:stock) { Faker::Number.between(1, 100) }
    let(:price) { Faker::Commerce.price(10..99.9, as_string: true) }
    let(:custom_attributes) { Faker::ChuckNorris.fact }
    let(:valid_attributes) do
      {
        name: name,
        description: description,
        stock: stock,
        price: price,
        custom_attributes: custom_attributes
      }
    end

    context 'when the request is valid' do
      before { post '/products', params: valid_attributes }

      it 'creates a new contact' do
        expect(json['name']).to eq name
        expect(json['description']).to eq description
        expect(json['stock']).to eq stock
        expect(json['price']).to eq price
        expect(json['custom_attributes']).to eq custom_attributes
      end

      it { expect(response).to have_http_status :created }
    end
  end
end
