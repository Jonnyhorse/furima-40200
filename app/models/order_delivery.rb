class OrderDelivery
  include ActiveModel::Model

  attr_accessor :user_id, :token, :product_id, :post_code, :delivery_area_id, :municipalities, :street_address, :building_name,
                :phone_number

  # form_withメソッドに対応する機能を追加
  # def self.model_name
  #   ActiveModel::Name.new(self, nil, "Order")
  # end

  validates_presence_of :municipalities, :street_address, :phone_number, :post_code
  validates :token, :user_id, :product_id, presence: true

  # 配送先の都道府県について、ジャンルの選択が「---」の時は保存できないようにする
  validates :delivery_area_id, numericality: { other_than: 1, message: 'must be selected' }

  # 郵便番号は、数字3桁、ハイフン、数字4桁の並びのみ許可する
  validates :post_code,
            format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-) and use only half-width digits' }

  # 電話番号は、半角数字10桁以上11桁以外では登録できない
  validates :phone_number, numericality: { only_integer: true, message: 'must be an integer' },
                           length: { minimum: 10, maximum: 11, message: 'must be 10 to 11 digits' }

  # validates :user_id
  # def error_messages
  #   errors.full_messages
  # end

  # ここにデータをテーブルに保存する処理を追加

  # 0以外の整数を許可する
  # validates :prefecture, numericality: {other_than: 0, message: "can't be blank"}

  def save
    return false unless valid?

    # 寄付情報を保存し、変数donationに代入する
    order = Order.create(product_id:, user_id:)
    # 住所を保存する
    # donation_idには、変数donationのidと指定する
    delivery = Delivery.create(
      post_code:,
      delivery_area_id:,
      municipalities:,
      street_address:,
      building_name:,
      phone_number:,
      order_id: order.id
    )
    # データ保存が成功した場合は true を返す
    delivery.persisted?
  end
end
