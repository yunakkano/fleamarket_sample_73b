class Item < ApplicationRecord
  has_many :item_imgs, dependent: :destroy
  belongs_to :category
  belongs_to :brand
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :preparation_day
  belongs_to_active_hash :postage_type
  belongs_to :seller, class_name: "user"
  belongs_to :buyer, class_name: "user"
end
