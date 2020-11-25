FactoryBot.define do
  factory :user do
    nickname                { Faker::Name.initials(number: 2) }
    email                   { Faker::Internet.free_email }
    password                { Faker::Internet.password(min_length: 6) }
    password_confirmation   { password }
    last_name               { 'てス山' }
    first_name              { 'てス太郎' }
    kana_last_name          { 'テスヤマ' }
    kana_first_name         { 'テスタロウ' }
    birthday                { Faker::Date.birthday(min_age: 20, max_age: 100) }
  end
end
