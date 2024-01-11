class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :first_name_chinese_character, presence: true
  validates :last_name_chinese_character, presence: true
  validates :first_name_katakana, presence: true
  validates :last_name_katakana, presence: true
  validates :nick_name, presence: true
  validates :date_of_birth, presence: true
end
