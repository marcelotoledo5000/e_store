require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'POST /products' do
    let(:name) { Faker::Beer.name }
    let(:description) { Faker::Beer.style }
    let(:stock) { Faker::Number.between(1, 100) }
    let(:price) { Faker::Commerce.price(10..99.9, as_string: true) }
    let(:custom_attributes) { Faker::ChuckNorris.fact }
    let(:invalid_attributes) { { name: name } }
    let(:valid_attributes) do
      {
        name: name,
        description: description,
        stock: stock,
        price: price,
        custom_attributes: custom_attributes
      }
    end

    context 'when the request is invalid' do
      before { post '/products', params: invalid_attributes }

      it { expect(response).to have_http_status :unprocessable_entity }
    end

    context 'when the request is valid' do
      before { post '/products', params: valid_attributes }

      it 'creates a new contact' do
        expect(json['name']).to eq name
        expect(json['description']).to eq description
        expect(json['stock']).to eq stock
        expect(format('%.2f', json['price'])).to eq price
        expect(json['custom_attributes']).to eq custom_attributes
      end

      it { expect(response).to have_http_status :created }
    end
  end

  describe 'GET /products' do
    context 'when returns empty' do
      before { get '/products' }

      it { expect(json).to be_empty }
      it { expect(json.size).to eq 0 }
    end

    context 'when returns products' do
      before do
        create_list(:product, 75)
        get '/products'
      end

      it { expect(json).not_to be_empty }
      it { expect(json.size).to eq 20 }
      it { expect(Product.count).to eq 75 }
    end
  end
end
