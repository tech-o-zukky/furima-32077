FactoryBot.define do
  factory :order_information do
    zipcode               { '123-4567' }
    prefecture_id         { Faker::Number.within(range: 2..48) }
    city                  { '横浜市' }
    address               { 'テスト町1-1' }
    address_building_name { 'テストビルディング' }
    telephone             { '09012345678' }
    token                 { 'tok_abcdefghijk00000000000000000' }
  end
end
