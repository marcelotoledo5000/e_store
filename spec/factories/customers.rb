FactoryBot.define do
  factory :customer do
    name { Faker::Books::Dune.character }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    email { Faker::Internet.email }
    birthday { Faker::Date.birthday(18, 65) }
  end
end
