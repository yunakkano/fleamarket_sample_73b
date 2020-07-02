class Item < ApplicationRecord
  has_many :item_imgs, dependent: :destroy
  accepts_nested_attributes_for :item_imgs
  belongs_to :category
  belongs_to :brand
  belongs_to :item_condition
  belongs_to :postage_payer
  belongs_to :preparation_day
  belongs_to :postage_type
  belongs_to :seller, class_name: "user"
  belongs_to :buyer, class_name: "user"
end
