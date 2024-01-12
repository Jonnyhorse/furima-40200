require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nick_nameが空では登録できない' do
      user = User.new(nick_name: '', email: 'test@example', password: '000000', password_confirmation: '000000')
      user.valid?
      binding.pry
      expect(user.errors.full_messages).to include("Nick name can't be blank")
    end
    it 'emailが空では登録できない' do
      # emailが空では登録できないテストコードを記述します
    end
  end
end
