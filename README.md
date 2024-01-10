# テーブル設計


## users テーブル

| Column                       | Type   | Options                   | 
| ---------------------------- | ------ | ------------------------- |
| email                        | string | null: false, unique: true |
| encrypted_password           | string | null: false               |
| first_name_chinese_character | string | null: false               |
| last_name_chinese_character  | string | null: false               |
| first_name_katakana          | string | null: false               |
| last_name_katakana           | string | null: false               |
| nick_name                    | string | null: false               |
| date_of_birth                | date   | null: false               |

### Association

- has_many :products
- has_many :purchase_records


## products テーブル

| Column               | Type             | Options                        |
| -------------------- | ---------------- | ------------------------------ |
| product_name         | string           | null: false                    |
| product_information  | text             | null: false                    |
| product_category_id  | integer          | null: false                    |
| product_condition_id | integer          | null: false                    |
| shipping_charge_id   | integer          | null: false                    |
| shipping_area_id     | integer          | null: false                    |
| shipping_day_id      | integer          | null: false                    |
| selling_price        | integer          | null: false                    |
| user                 | references: user | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_record


## purchase_records テーブル

| Column  | Type                | Options                        |
| ------- | ------------------- | ------------------------------ |
| user    | references: user    | null: false, foreign_key: true |
| product | references: product | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product
- has_one :shipping_information


## deliveries テーブル

| Column           | Type                        | Options                        |
| ---------------- | --------------------------- | ------------------------------ |
| post_code        | string                      | null: false                    |
| shipping_area_id | integer                     | null: false                    |
| municipalities   | string                      | null: false                    |
| street_address   | string                      | null: false                    |
| building_name    | string                      |
| phone_number     | string                      | null: false                    |
| purchase_record  | references: purchase_record | null: false, foreign_key: true |


### Association

- belongs_to :purchase_record