class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name_chinese_character, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: "は全角で入力してください" }
  validates :last_name_chinese_character, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: "は全角で入力してください" }
  validates :first_name_katakana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力してください" }
  validates :last_name_katakana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力してください" }
  validates :nick_name, presence: true
  validates :date_of_birth, presence: true
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]+\z/, message: "は半角英数字を含む6文字以上で入力してください" }

  has_many :products
  has_many :purchase_records
end
