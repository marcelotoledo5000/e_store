# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { Faker::Books::Dune.character }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    email { Faker::Internet.email }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
