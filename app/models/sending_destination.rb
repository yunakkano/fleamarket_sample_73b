class SendingDestination < ApplicationRecord
  belongs_to :user
  
  include JpPrefecture
  jp_prefecture :prefecture_code

  validates :dest_first_name, :dest_family_name, :city, presence: true,
    format: {with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: '全角で入力してください。'}

  validates :dest_first_name_kana, :dest_family_name_kana, presence: true,
    format: {with: /\A[ぁ-んー－]+\z/, message: 'ひらがなで入力してください。'}

  validates :post_code, format: {with: /\A\d{7}\z/, message: 'ハイフン無しで7桁の数字を入力してください。'}

  validates :phone_number, format: {with: /\A\d{11}\z/, message: "ハイフン無しで11桁の数字を入力してください。"}

  validates :post_code, :prefecture_code, :street_number, presence: true
  #市区町村の形式は？　郵便番号から自動フィルを実装

end
