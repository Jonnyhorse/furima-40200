class OrderDelivery

  include ActiveModel::Model
  # ここにクラスの実装を追加

  # ordersテーブルのカラム
  attr_accessor :user_id, :product_id

  # deliveriesテーブルのカラム
  attr_accessor :post_code, :delivery_area_id, :municipalities, :street_address, :building_name, :phone_number


  # form_withメソッドに対応する機能を追加
  # def self.model_name
  #   ActiveModel::Name.new(self, nil, "Order")
  # end

  #空の投稿を保存できないようにする
  validates :post_code, presence: true
  validates :municipalities, presence: true
  validates :street_address, presence: true
  validates :phone_number, presence: true

  # 配送先の都道府県について、ジャンルの選択が「---」の時は保存できないようにする
  validates :delivery_area_id, numericality: { other_than: 1, message: 'must be selected' }
  
  #フォーマット以外の値では保存できない
  validates :post_code, format: { with: /\A\d{7}\z/, message: 'should be in the format XXX-XXXX' }
  
  #半角数字以外では登録できない
  validates  :phone_number, numericality: { only_integer: true, message: 'must be an integer' }
  
  # def error_messages
  #   errors.full_messages
  # end

  # ここにデータをテーブルに保存する処理を追加
end
