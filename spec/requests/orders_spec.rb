require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  describe 'POST /orders' do
    let(:products) { create_list(:product, 2) }
    let(:customer) { create(:customer) }
    let(:date) { Faker::Date.between(2.days.ago, Date.today) }
    let(:freight) { Faker::Commerce.price(5..19.9, as_string: true) }
    let(:items) do
      [
        {
          product_id: products.first.id,
          quantity: 5
        },
        {
          product_id: products.last.id,
          quantity: 10
        }
      ]
    end
    let(:invalid_attributes) { { bla: 'bla' } }
    let(:valid_attributes) do
      {
        date: formatted_date(date),
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

      it 'creates a new contact' do
        expect(formatted_date(json['date'])).to eq formatted_date(date)
        expect(json['customer_id']).to eq customer.id
        expect(json['status']).to eq Order.last.status
        expect(json['freight']).to eq freight
        expect(json['items']).to eq items
      end

      it { expect(response).to have_http_status :created }
    end
  end
end
