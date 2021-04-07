FactoryBot.define do
  factory :item do
    name { Faker::Movies::StarWars.specie }
    description { Faker::Movies::StarWars.quote }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    merchant
  end
end
