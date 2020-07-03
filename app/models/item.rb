class Item < ApplicationRecord
  after_initialize :set_default_trading_status
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :item_imgs, dependent: :destroy
  accepts_nested_attributes_for :item_imgs, allow_destroy: true
  belongs_to :category
  belongs_to :brand
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :preparation_day
  belongs_to_active_hash :postage_type
  belongs_to :seller, class_name: "user"
  belongs_to :buyer, class_name: "user"

  include JpPrefecture
  jp_prefecture :prefecture_code

  private

  def set_default_trading_status
    self.trading_status = 0
  end
end
