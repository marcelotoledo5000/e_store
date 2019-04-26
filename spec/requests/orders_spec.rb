require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  describe 'POST /orders' do
    let(:products) { create_list(:product, 2) }
    let(:customer) { create(:customer) }
    let(:freight) { Faker::Commerce.price(5..19.9, as_string: true) }
    let(:items) do
      [
        {
          product_id: products.first.id,
          quantity: Faker::Number.between(5, 20)
        },
        {
          product_id: products.last.id,
          quantity: Faker::Number.between(5, 15)
        }
      ]
    end
    let(:invalid_attributes) { { bla: 'bla', items: [] } }
    let(:valid_attributes) do
      {
        customer_id: customer.id,
        freight: freight,
        items: items
      }
    end

    context 'when the request is invalid' do
      before { post '/orders', params: invalid_attributes }

      it { expect(response).to have_http_status :unprocessable_entity }
    end

    context 'when the request is valid' do
      before { post '/orders', params: valid_attributes }

      it 'creates a new order' do
        expect(json['customer_id']).to eq customer.id
        expect(json['status']).to eq Order.last.status
        expect(formatted_currency(json['freight'])).
          to eq formatted_currency freight
        expect(Order.last.items[0].product_id).to eq items[0][:product_id]
        expect(Order.last.items[0].quantity).to eq items[0][:quantity]
        expect(Order.last.items[1].product_id).to eq items[1][:product_id]
        expect(Order.last.items[1].quantity).to eq items[1][:quantity]
        expect(Order.last.status).to eq 'received'
      end

      it { expect(response).to have_http_status :created }
    end
  end

  describe 'validations' do
    let(:customer) { create(:customer) }
    let(:freight) { Faker::Commerce.price(5..19.9, as_string: true) }
    let(:valid_attributes) do
      {
        customer_id: customer.id,
        freight: freight,
        items: items
      }
    end

    context 'when stock is available for one item' do
      let(:product) { create(:product, stock: 5) }
      let(:items) do
        [
          {
            product_id: product.id,
            quantity: 5
          }
        ]
      end

      before { post '/orders', params: valid_attributes }

      it 'creates the order and decreases the stock' do
        expect(Item.last.product_id).to eq product.id
        expect(Order.last.items[0].id).to eq Item.last.id
        product.reload
        expect(product.stock).to eq 0
      end
    end

    context 'when stock is available for all items' do
      let(:product1) { create(:product, stock: 5) }
      let(:product2) { create(:product, stock: 5) }
      let(:product3) { create(:product, stock: 5) }
      let(:items) do
        [
          {
            product_id: product1.id,
            quantity: 3
          },
          {
            product_id: product2.id,
            quantity: 4
          },
          {
            product_id: product3.id,
            quantity: 5
          }
        ]
      end

      before { post '/orders', params: valid_attributes }

      it 'creates the order and decreases the stock of all items' do
        expect(Item.last.product_id).to eq product3.id
        expect(Order.last.items[2].id).to eq Item.last.id
        product1.reload
        product2.reload
        product3.reload
        expect(product1.stock).to eq 2
        expect(product2.stock).to eq 1
        expect(product3.stock).to eq 0
      end
    end

    context 'when stock is not available for least one item' do
      let(:product1) { create(:product, stock: 5) }
      let(:product2) { create(:product, stock: 5) }
      let(:product3) { create(:product, stock: 5) }
      let(:items) do
        [
          {
            product_id: product1.id,
            quantity: 3
          },
          {
            product_id: product2.id,
            quantity: 4
          },
          {
            product_id: product3.id,
            quantity: 6
          }
        ]
      end

      subject { post '/orders', params: valid_attributes }

      it 'raise error and does not creates the order' do
        expect { subject }.
          to raise_exception StockIsNotAvailable, 'Stock is not available'
      end

      it { expect(product1.reload.stock).to eq 5 }
      it { expect(product2.reload.stock).to eq 5 }
      it { expect(product3.reload.stock).to eq 5 }
    end

    context 'when product is not foud' do
      let(:products) { create_list(:product, 2) }
      let(:stock1) { products.first.stock }
      let(:stock2) { products.last.stock }
      let(:items) do
        [
          {
            product_id: products.first.id,
            quantity: 3
          },
          {
            product_id: 10_000,
            quantity: 10
          },
          {
            product_id: products.last.id,
            quantity: 6
          }
        ]
      end

      before { post '/orders', params: valid_attributes }

      it { expect(response).to have_http_status :not_found }
      it { expect(response.body).to match(/Couldn't find Product with 'id'=/) }
      it { expect(products.first.reload.stock).to eq stock1 }
      it { expect(products.last.reload.stock).to eq stock2 }
    end
  end

  describe 'GET /orders' do
    context 'when returns empty' do
      before { get '/orders' }

      it { expect(json).to be_empty }
      it { expect(json.size).to eq 0 }
    end

    context 'when returns orders' do
      before do
        create_list(:order_with_items, 30)
        get '/orders'
      end

      it { expect(json).not_to be_empty }
      it { expect(json.size).to eq 20 }
      it { expect(Order.count).to eq 30 }
    end
  end
end
