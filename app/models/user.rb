class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, password_length: 7..128
  has_one :profile, dependent: :destroy
  has_one :sending_destination, dependent: :destroy
  has_one :card, dependent: :destroy
  has_one :self_introduction, dependent: :destroy
  has_many :seller_items, foreign_key: "seller_id", class_name: "items"
  has_many :buyer_items, foreign_key: "buyer_id", class_name: "items"
  has_many :favorites, dependent: :destroy
  has_many :favorite_items, through: :favorites, source: :item

  validates :nickname, presence: true
end