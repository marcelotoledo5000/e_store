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

  describe 'GET /products/:id' do
    let!(:product) { create(:product) }

    before do
      get "/products/#{product_id}"
    end

    context 'when product is not found' do
      let(:product_id) { 'not_found' }

      it { expect(json).not_to be_empty }

      it 'returns status code 404' do
        expect(response).to have_http_status :not_found
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end

    context 'when the record exists' do
      let(:product_id) { product.id }

      it { expect(json).not_to be_empty }
      it { expect(response).to have_http_status :ok }
    end
  end

  describe 'PUT /products/:id' do
    let!(:product) { create(:product) }
    let(:new_name) { Faker::Beer.name }
    let(:new_description) { Faker::Beer.style }
    let(:new_attributes) do
      {
        name: new_name,
        description: new_description
      }
    end

    before do
      put "/products/#{product_id}",
          params: new_attributes
    end

    context 'when product is not found' do
      let(:product_id) { 'not_found' }

      it { expect(json).not_to be_empty }

      it 'returns status code 404' do
        expect(response).to have_http_status :not_found
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end

    context 'when the record exists' do
      let(:product_id) { product.id }

      it { expect(json).not_to be_empty }
      it { expect(response).to have_http_status :created }
      it 'updates the record' do
        product.reload
        expect(json['name']).to eq new_name
        expect(json['description']).to eq new_description
        expect(json['stock']).to eq product.stock
        expect(format('%.2f', json['price'])).
          to eq format('%.2f', product.price)
        expect(json['custom_attributes']).to eq product.custom_attributes
      end
    end
  end
end
