require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      product = FactoryBot.create(:product)
      @order_delivery = FactoryBot.build(:order_delivery, user_id: user.id, product_id: product.id)
    end

    context '内容に問題がない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_delivery).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_delivery.building_name = ''
        expect(@order_delivery).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと保存できないこと' do
        @order_delivery.post_code = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_delivery.post_code = '1111111'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Post code is invalid. Include hyphen(-) and use only half-width digits')
      end
      it 'delivery_area_idが[---]だと保存できないこと' do
        @order_delivery.delivery_area_id = '1'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Delivery area must be selected')
      end
      it 'municipalitiesが空だと保存できないこと' do
        @order_delivery.municipalities = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Municipalities can't be blank")
      end
      it 'street_addressが空だと保存できないこと' do
        @order_delivery.street_address = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Street address can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @order_delivery.phone_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが半角数値9桁以下の場合は保存できないこと' do
        @order_delivery.phone_number = '1'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number must be 10 to 11 digits')
      end
      it 'phone_numberが半角数値12桁以上の場合は保存できないこと' do
        @order_delivery.phone_number = '111111111111'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number must be 10 to 11 digits')
      end
      it 'phone_numberが数値以外の場合は保存できないこと' do
        @order_delivery.phone_number = '１'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number must be an integer')
      end
      it 'userが紐付いていないと保存できないこと' do
        @order_delivery.user_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("User can't be blank")
      end
      it 'productが紐付いていないと保存できないこと' do
        @order_delivery.product_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Product can't be blank")
      end
      it 'tokenが空では登録できないこと' do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
