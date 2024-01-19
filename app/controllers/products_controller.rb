class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @products = Product.all.order('created_at DESC')
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      # 商品が正常に保存された場合の処理（通常は商品一覧ページなどにリダイレクトする）
      redirect_to products_path, notice: '商品を登録しました。'
    else
      # バリデーションエラーが発生した場合の処理
      p @product.errors.full_messages # ターミナルにエラーメッセージを表示
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:name, :information, :selling_price, :category_id, :condition_id, :delivery_charge_id,
                                    :delivery_area_id, :delivery_day_id, :user_id, :image)
  end
end
