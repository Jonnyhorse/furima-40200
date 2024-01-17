FactoryBot.define do
  factory :product do
    # 必要な属性を追加する
    name { 'Example Product' }
    information { 'This is a sample product.' }
    selling_price { Faker::Commerce.price(range: 1000..10_000) }
    category_id = 2
    condition_id = 2
    delivery_area_id = 2
    delivery_charge_id = 2
    delivery_day_id = 2
  end
end
