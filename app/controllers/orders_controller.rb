class OrdersController < ApplicationController

  def index
    @products = Product.find(params[:product_id])
  end

  def create
  end
end
