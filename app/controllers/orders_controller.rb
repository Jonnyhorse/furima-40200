class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @product = Product.find(params[:product_id])
    if @product.user_id == current_user.id
      redirect_to root_path
    end
    if @product.order.present?
      redirect_to root_path
    end
    @order_delivery = OrderDelivery.new
  end


  def create
    @product = Product.find(params[:product_id])
    @order_delivery = OrderDelivery.new(order_delivery_params)
    if @order_delivery.valid?
      pay_item
      @order_delivery.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_delivery_params
    product = Product.find(params[:product_id])
    params.require(:order_delivery).permit(:post_code, :delivery_area_id, :municipalities,:street_address, :building_name, :phone_number).merge(token: params[:token], user_id: current_user.id, product_id: params[:product_id], selling_price: product.selling_price )
  end

  def pay_item
    Payjp.api_key = "sk_test_b2d2876ae845868b5dec2751"  # 自身のPAY.JPテスト秘密鍵を記述しましょう 
    puts "Charge params: #{order_delivery_params[:selling_price]}, #{order_delivery_params[:token]}"
    Payjp::Charge.create(
      amount: order_delivery_params[:selling_price],  # 商品の値段
      card: order_delivery_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
