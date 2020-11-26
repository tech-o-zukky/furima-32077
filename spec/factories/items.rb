FactoryBot.define do
  factory :item do
    item_name                    { Faker::Lorem.word }
    item_explanation             { Faker::Lorem.sentence }
    item_category_id             { Faker::Number.within(range: 2..11) }
    item_scheduled_delivery_id   { Faker::Number.within(range: 2..4) }
    item_shipping_fee_status_id  { Faker::Number.within(range: 2..3) }
    item_status_id               { Faker::Number.within(range: 2..7) }
    prefecture_id                { Faker::Number.within(range: 2..48) }
    sell_price                   { Faker::Number.within(range: 300..9_999_999) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
