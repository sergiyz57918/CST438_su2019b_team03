FactoryBot.define do
  factory :todo do
    itemId { Faker::Number.number(10) }
    description {Faker::Lorem.word }
    customerId { Faker::Number.number(10) }
    price {Faker::Number.positive}
    award {Faker::Number.positive}
    total {price - award}
  end
end