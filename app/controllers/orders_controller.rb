class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @product = Product.find(params[:product_id])
    @order_delivery = OrderDelivery.new
  end


  def create
    @product = Product.find(params[:product_id])
    @order_delivery = OrderDelivery.new(order_params)
    if @order_delivery.valid?
      @order_delivery.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_delivery).permit(:post_code, :delivery_area_id, :municipalities,:street_address, :building_name, :phone_number).merge(user_id: current_user.id, product_id: @product.id)
  end

end
