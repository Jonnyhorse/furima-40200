FactoryBot.define do
  factory :user do
    nick_name { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password { Faker::Lorem.characters(number: 6) + Faker::Number.number(digits: 2).to_s }
    password_confirmation { password }
    first_name_chinese_character { '山田' }
    last_name_chinese_character { '孝之' }
    first_name_katakana { 'ヤマダ' }
    last_name_katakana { 'タカユキ' }
    date_of_birth { 19_900_101 }
  end
end
