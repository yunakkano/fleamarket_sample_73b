class SendingDestination < ApplicationRecord
  belongs_to :user
  
  include JpPrefecture
  jp_prefecture :prefecture_code

  validates :dest_first_name, :dest_family_name, :city, presence: true,
    format: {with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: 'は全角で入力してください。'}

  validates :dest_first_name_kana, :dest_family_name_kana, presence: true,
    format: {with: /\A[ぁ-んー－]+\z/, message: 'はひらがなで入力してください。'}

  validates :post_code, format: {with: /\A\d{7}\z/, message: 'はハイフン無しで数字7桁を入力してください。'}

  validates :phone_number, format: {with: /\A(\d{10}|\d{11})\z/, message: "はハイフン無しで数字10桁又は数字11桁を入力してください。"}

  validates :post_code, :prefecture_code, :street_number, presence: true

end
