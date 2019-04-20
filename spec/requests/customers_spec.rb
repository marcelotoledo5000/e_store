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

      it 'creates a new contact' do
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
end
