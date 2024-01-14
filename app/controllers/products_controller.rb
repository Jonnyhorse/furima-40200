class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  
  def index
    @products = Product.order("created_at DESC")
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      # 商品が正常に保存された場合の処理（通常は商品一覧ページなどにリダイレクトする）
      redirect_to products_path, notice: '商品を登録しました。'
    else
      # バリデーションエラーが発生した場合の処理
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :condition, :shipping_fee, :shipping_method, :prefecture_id, :shipping_days, :image)
  end
end
