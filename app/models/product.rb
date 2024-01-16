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

  #販売価格が299円以下のときは保存できないようにする
  validates :selling_price, numericality: { greater_than: 299, message: "must be greater than 299" }

  #販売価格が10,000,000円以上のときは保存できないようにする
  validates :selling_price, numericality: { less_than: 10_000_000, message: "must be less than 10,000,000" }

  #販売価格が全角数字のときは保存できないようにする
  validate :selling_price_must_be_halfwidth_digits

  #販売価格が数字以外のときは保存できないようにする
  validates :selling_price, numericality: { only_integer: true, message: "must be an integer" }

  private

  def selling_price_must_be_halfwidth_digits
    unless selling_price.to_s =~ /\A[0-9]+\z/
      errors.add(:selling_price, "must be halfwidth digits")
    end
  end
end