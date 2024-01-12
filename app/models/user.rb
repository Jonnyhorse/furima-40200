class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name_chinese_character, presence: true
  validates :last_name_chinese_character, presence: true
  validates :first_name_katakana, presence: true
  validates :last_name_katakana, presence: true
  validates :nick_name, presence: true
  validates :date_of_birth, presence: true
  validates :password,
            presence: true,
            length: { minimum: 6 },
            format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]+\z/, message: "は半角英数字を含む6文字以上で入力してください" }
end
