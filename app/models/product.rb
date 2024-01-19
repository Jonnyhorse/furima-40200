class Product < ApplicationRecord
  belongs_to :user
  # belongs_to :purchase_records
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
  validates :category_id, :condition_id, :delivery_area_id, :delivery_charge_id, :delivery_day_id,
            numericality: { other_than: 1, message: 'must be selected' }

  # 販売価格が299円以下のときは保存できないようにする
  validates :selling_price, numericality: { only_integer: true, greater_than: 299, message: 'must be greater than 299' }

  # 販売価格が10,000,000円以上のときは保存できないようにする
  validates :selling_price, numericality: { only_integer: true, less_than: 10_000_000, message: 'must be less than 10,000,000' }

  # 販売価格が数字以外のときは保存できないようにする
  validates :selling_price, numericality: { only_integer: true, message: 'must be an integer' }

  # 販売価格が整数以外のときは保存できないようにする
  validates :selling_price, presence: true, numericality: { only_integer: true, message: 'must be an integer' }

  private

  def selling_price_must_be_halfwidth_digits
    return if selling_price.is_a?(Integer)

    errors.add(:selling_price, 'must be an integer')
  end
end
