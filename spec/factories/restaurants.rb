FactoryBot.define do
  factory :restaurant do
    name { Faker::Restaurant.name }
    email { Faker::Internet.email }
    phone_number { "+62211234#{rand(10..99)}#{rand(0..9)}#{Time.now.to_i % 100}" }
    address { Faker::Address.full_address }
  end
end
