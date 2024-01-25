FactoryBot.define do
  factory :order_delivery do
    post_code { '123-4567' }
    delivery_area_id { 2 }
    municipalities { '札幌市' }
    street_address { '11-1' }
    building_name {}
    phone_number { '08011112222' }
    token { 'tok_abcdefghijk00000000000000000' }
    product_id { 10 }
  end
  # association :order
end
