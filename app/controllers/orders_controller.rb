class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:index, :create]

  def index
    if @product.user_id == current_user.id || @product.order.present?
      redirect_to root_path
      return # アクションの実行をここで終了
    end
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_delivery = OrderDelivery.new
  end

  def create
    @order_delivery = OrderDelivery.new(order_delivery_params)
    if @order_delivery.valid?
      pay_item
      @order_delivery.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def order_delivery_params
    product = Product.find(params[:product_id])
    params.require(:order_delivery).permit(:post_code, :delivery_area_id, :municipalities, :street_address, :building_name, :phone_number).merge(
      token: params[:token], user_id: current_user.id, product_id: params[:product_id], selling_price: product.selling_price
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: order_delivery_params[:selling_price], # 商品の値段
      card: order_delivery_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end
