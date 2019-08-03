FactoryBot.define do
  factory :todo do
    itemId { Faker::Number.number(10) }
    customerId { Faker::Number.number(10) }
  end
end