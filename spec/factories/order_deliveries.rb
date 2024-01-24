FactoryBot.define do
  factory :order_delivery do
    post_code {'123-4567'}
    delivery_area_id { 2 }
    municipalities {'札幌市'}
    street_address {'11-1'}
    building_name {}
    phone_number {'080-1111-2222'}
  end
  #association :order
end
