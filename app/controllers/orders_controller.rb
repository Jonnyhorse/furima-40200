class OrdersController < ApplicationController

  def index
    @products = Product.find(params[:product_id])
  end

  def create
    binding.pry
    @order_delivery = OrderDelivery.new(set_params)
    if @order_delivery.save
      # 商品が正常に保存された場合の処理（通常は商品一覧ページなどにリダイレクトする）
      redirect_to orders_path, notice: '商品を登録しました。'
    else
      # バリデーションエラーが発生した場合の処理
      p @order_delivery.errors.full_messages # エラーメッセージを表示
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_params
    params.require(:order_delivery).permit(:delivery_area_id, :product_id, :other_params)
  end
end
