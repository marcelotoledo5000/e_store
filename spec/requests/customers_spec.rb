require 'rails_helper'

RSpec.describe 'Customers', type: :request do
  describe 'POST /customers' do
    let(:name) { Faker::Books::Dune.character }
    let(:cpf) { Faker::IDNumber.brazilian_citizen_number }
    let(:email) { Faker::Internet.email }
    let(:birthday) { Faker::Date.birthday(18, 65) }
    let(:invalid_attributes) { { name: name } }
    let(:valid_attributes) do
      {
        name: name,
        cpf: cpf,
        email: email,
        birthday: formatted_date(birthday)
      }
    end

    context 'when the request is invalid' do
      before { post '/customers', params: invalid_attributes }

      it { expect(response).to have_http_status :unprocessable_entity }
    end

    context 'when the request is valid' do
      before { post '/customers', params: valid_attributes }

      it 'creates a new customer' do
        expect(json['name']).to eq name
        expect(json['cpf']).to eq cpf
        expect(json['email']).to eq email
        expect(formatted_date(json['birthday'])).to eq formatted_date(birthday)
      end

      it { expect(response).to have_http_status :created }
    end
  end

  describe 'GET /customers' do
    context 'when returns empty' do
      before { get '/customers' }

      it { expect(json).to be_empty }
      it { expect(json.size).to eq 0 }
    end

    context 'when returns customers' do
      before do
        create_list(:customer, 50)
        get '/customers'
      end

      it { expect(json).not_to be_empty }
      it { expect(json.size).to eq 20 }
      it { expect(Customer.count).to eq 50 }
    end
  end

  describe 'GET /customers/:id' do
    let!(:customer) { create(:customer) }

    before do
      get "/customers/#{customer_id}"
    end

    context 'when customer is not found' do
      let(:customer_id) { 'not_found' }

      it { expect(json).not_to be_empty }

      it 'returns status code 404' do
        expect(response).to have_http_status :not_found
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Customer/)
      end
    end

    context 'when the record exists' do
      let(:customer_id) { customer.id }

      it { expect(json).not_to be_empty }
      it { expect(response).to have_http_status :ok }
    end
  end

  describe 'PUT /customers/:id' do
    let!(:customer) { create(:customer) }
    let(:new_name) { Faker::Books::Dune.character }
    let(:new_email) { Faker::Internet.email }
    let(:new_attributes) do
      {
        name: new_name,
        email: new_email
      }
    end

    before do
      put "/customers/#{customer_id}",
          params: new_attributes
    end

    context 'when customer is not found' do
      let(:customer_id) { 'not_found' }

      it { expect(json).not_to be_empty }

      it 'returns status code 404' do
        expect(response).to have_http_status :not_found
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Customer/)
      end
    end

    context 'when the record exists' do
      let(:customer_id) { customer.id }

      it { expect(json).not_to be_empty }
      it { expect(response).to have_http_status :created }
      it 'updates the record' do
        customer.reload
        expect(json['name']).to eq new_name
        expect(json['email']).to eq new_email
        expect(json['cpf']).to eq customer.cpf
        expect(formatted_date(json['birthday'])).
          to eq formatted_date(customer.birthday)
      end
    end
  end
end
