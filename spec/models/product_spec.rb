require 'rails_helper'
RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end



  describe '商品出品' do
    it 'すべての項目が正しく記入されていれば登録できる' do
      expect(@product).to be_valid
    end

    it '商品名が空では登録できない' do
      @product.name = ''
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it '商品情報が空では登録できない' do
      @product.information = ''
      @product.valid?
      expect(@product.errors.full_messages).to include("Information can't be blank can't be blank")
    end
    it '販売価格が空では登録できない' do
      @product.selling_price = ''
      @product.valid?
      expect(@product.errors.full_messages).to include("Selling price can't be blank")
    end
    it '販売価格が299円以下では登録できない' do
      @product.selling_price = '1'
      @product.valid?
      expect(@product.errors.full_messages).to include("Selling price must be greater than 299")
    end
    it '販売価格が10,000,000円以上では登録できない' do
      @product.selling_price = '10000000'
      @product.valid?
      expect(@product.errors.full_messages).to include("Selling price must be less than 10,000,000")
    end
    it '販売価格が全角の場合は登録できない' do
      @product.selling_price = '３００'
      @product.valid?
      expect(@product.errors.full_messages).to include("Selling price must be an integer")
    end
    it '販売価格が数値以外の場合は登録できない' do
      @product.name = 'てすと'
      @product.valid?
      expect(@product.errors.full_messages).to include("Selling price must be an integer")
    end
    it '商品画像が1枚以上添付されていないと登録できない' do
      @product.image = ''
      @product.valid?
      expect(@product.errors.full_messages).to include("Image can't be blank")
    end
    it 'カテゴリー欄が[---]の場合は登録できない' do
      @product.category_id = 1 # 1が「---」のIDに対応すると仮定しています
      @product.valid?
      expect(@product.errors.full_messages).to include("Category must be selected")
    end
    it '商品の状態欄が[---]の場合は登録できない' do
      @product.condition_id = 1 # 1が「---」のIDに対応すると仮定しています
      @product.valid?
      expect(@product.errors.full_messages).to include("Condition must be selected")
    end
    it '発送元の地域欄が[---]の場合は登録できない' do
      @product.delivery_area_id_id = 1 # 1が「---」のIDに対応すると仮定しています
      @product.valid?
      expect(@product.errors.full_messages).to include("delivery_area must be selected")
    end
    it '配送料の負担欄が[---]の場合は登録できない' do
      @product.delivery_charge_id = 1  # 1が「---」のIDに対応すると仮定しています
      @product.valid?
      expect(@product.errors.full_messages).to include("Delivery_charge must be selected")
    end
    it '商品の発送日欄が[---]の場合は登録できない' do
      @product.delivery_day_id = 1 # 1が「---」のIDに対応すると仮定しています
      @product.valid?
      expect(@product.errors.full_messages).to include("Delivery_area must be selected")
    end
  end
end
