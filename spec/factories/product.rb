FactoryBot.define do
  factory :product do
    # 必要な属性を追加する
    name { "Example Product" }
    description { "This is a sample product." }
    price { 1000 }
    # 他の属性も追加する
  end
end