# テーブル設計


## users テーブル

| Column                  | Type    | Options  | 
| ----------------------- | ------- | -------- |
| email                   | string  | not null |
| encrypted_password      | string  | not null |
| name_chinese_characters | string  | not null |
| name_katakana           | string  | not null |
| nick_name               | string  | not null |
| date_of_birth           | integer | not null |

### Association

- has_many :products
- has_many :purchase_records


## products テーブル

| Column            | Type    | Options                     |
| ----------        | ------- | --------------------------- |
| product_image     | string  | not null                    |
| product_name      | string  | not null                    |
| product_category  | integer | not null                    |
| product_condition | integer | not null                    |
| shipping_charge   | integer | not null                    |
| shipping_area     | integer | not null                    |
| shipping_days     | integer | not null                    |
| selling_price     | integer | not null                    |
| seller_name       | string  | not null, foreign_key: true |

### Association

- belongs_to :users
- has_one : purchase records


## purchase_records テーブル

| Column  | Type    | Options                     |
| ------- | ------- | --------------------------- |
| name    | integer | not null, foreign_key: true |
| product | integer | not null, foreign_key: true |

### Association

- belongs_to :users
- has_one :products
- has_one :shippings_information


## shippings_information テーブル

| Column         | Type    | Options  |
| -------------- | ------- | ---------|
| post_code      | integer | not null |
| prefecture     | integer | not null |
| municipalities | string  | not null |
| street_address | string  | not null |
| building_name  | string  |
| phone_number   | integer | not null |


### Association

- has_one :purchase_records