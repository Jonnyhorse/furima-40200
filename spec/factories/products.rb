FactoryBot.define do
  factory :product do
    # 必要な属性を追加する
    name { 'Example Product' }
    information { 'This is a sample product.' }
    selling_price { Faker::Commerce.price(range: 1000..10_000) }
    # 他の属性も追加する
  end
end
