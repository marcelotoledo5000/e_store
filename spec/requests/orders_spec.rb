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
end
