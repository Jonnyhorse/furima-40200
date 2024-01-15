class Product < ApplicationRecord
  belongs_to :user
  has_one :purchase_record
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_area
  belongs_to :delivery_charge
  belongs_to :delivery_day

  # 空の投稿を保存できないようにする
  validates :name, presence: true
  validates :information, presence: true
  validates :selling_price, presence: true
  validates :image, presence: true

  # ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id, :condition_id, :delivery_area_id, :delivery_charge_id, :delivery_day_id, numericality: { other_than: 1, message: "must be selected"}
end