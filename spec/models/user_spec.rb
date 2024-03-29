require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nick_nameとemail、passwordとpassword_confirmation、漢字の姓と漢字の名、カタカナの姓とカタカナの名、生年月日が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nick_nameが空では登録できない' do
        @user.nick_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nick name can't be blank")
      end
      it '名前の姓(漢字)が空では登録できない' do
        @user.last_name_chinese_character = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name chinese character can't be blank")
      end
      it '名前の名(漢字)が空では登録できない' do
        @user.first_name_chinese_character = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name chinese character can't be blank")
      end
      it '名前の姓(漢字)に半角文字が含まれていると登録できない' do
        @user.last_name_chinese_character = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name chinese character は全角で入力してください')
      end
      it '名前の名(漢字)に半角文字が含まれていると登録できない' do
        @user.first_name_chinese_character = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name chinese character は全角で入力してください')
      end
      it '名前の姓(カタカナ)にカタカナ以外の文字が含まれていると登録できない' do
        @user.last_name_katakana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name katakana は全角カタカナで入力してください')
      end
      it '名前の名(カタカナ)にカタカナ以外の文字が含まれていると登録できない' do
        @user.first_name_katakana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name katakana は全角カタカナで入力してください')
      end
      it '名前の姓(カタカナ)が空では登録できない' do
        @user.last_name_katakana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name katakana can't be blank")
      end
      it '名前の名(カタカナ)が空では登録できない' do
        @user.first_name_katakana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name katakana can't be blank")
      end
      it '生年月日が空では登録できない' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birth can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it 'passwordが6文字未満では登録できない' do
        @user.password = 'abc12'
        @user.password_confirmation = 'abc12'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが半角英字のみの場合は登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字を含む6文字以上で入力してください')
      end

      it 'passwordが半角数字のみの場合は登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字を含む6文字以上で入力してください')
      end

      it 'passwordが全角の場合は登録できない' do
        @user.password = 'ａｂｃ１２３'
        @user.password_confirmation = 'ａｂｃ１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字を含む6文字以上で入力してください')
      end
    end
  end
end
