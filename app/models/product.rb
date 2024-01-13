class Product < ApplicationRecord
  belongs_to :user
  has_one :purchase_record
  has_one_attached :image
end
