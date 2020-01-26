# frozen_string_literal: true

require 'rails_helper'

describe 'ReportsController', type: :request do
  describe 'GET /reports/average_ticket' do
    let!(:order1) do
      order = create(:order_with_items)
      order.created_at = 10.days.ago
      order.save!
    end
    let!(:order4) { create(:order_with_items) }
    let!(:order2) do
      order = create(:order_with_items, items_count: 1)
      order.created_at = 5.days.ago
      order.save!
      order
    end
    let!(:order3) do
      order = create(:order_with_items, items_count: 1)
      order.created_at = 3.days.ago
      order.save!
      order
    end
    let(:period) do
      {
        initial_date: 7.days.ago,
        final_date: 1.day.ago
      }
    end
    let(:total_order_2) do
      item = order2.items.first.product.price * order2.items.first.quantity
      freight = order2.freight
      item + freight
    end
    let(:total_order_3) do
      item = order3.items.first.product.price * order3.items.first.quantity
      freight = order3.freight
      item + freight
    end

    context 'when the request is valid' do
      before do
        order1
        order4
        get '/reports/average_ticket', params: period
      end

      it { expect(response).to have_http_status :ok }

      it do
        order = Order.find order2.id
        subtotal = order.items.first.product.price * order.items.first.quantity
        total = subtotal + order.freight
        expect(total_order_2.round(2)).to eq total.round(2)
      end

      it do
        order = Order.find order3.id
        subtotal = order.items.first.product.price * order.items.first.quantity
        total = subtotal + order.freight
        expect(total_order_3.round(2)).to eq total.round(2)
      end

      it do
        average = (total_order_2 + total_order_3)
        expect(json).to eq((average / 2).round(2))
      end
    end

    context 'when the request is invalid' do
      before { get '/reports/average_ticket', params: invalid_period }

      xit { expect(response).to have_http_status :bad_request }
    end
  end
end
