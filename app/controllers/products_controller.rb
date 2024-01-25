class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

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
      p @product.errors.full_messages # エラーメッセージを表示
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  return redirect_to root_path if current_user != @product.user

  if @product.order.present?
    redirect_to root_path
  end
    
  end

  def update
    if @product.update(product_params)
      # 保存が成功した場合の処理
      redirect_to product_path
    else
      # 保存が失敗した場合の処理
      p @product.errors.full_messages # エラーメッセージを表示
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user == @product.seller
      @product.destroy
    end
    redirect_to root_path, notice: '商品を削除しました。'
  end

  private

  def product_params
    params.require(:product).permit(:name, :information, :selling_price, :category_id, :condition_id, :delivery_charge_id,
                                    :delivery_area_id, :delivery_day_id, :user_id, :image)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
