class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :item_imgs, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
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

  
  validates_associated :item_imgs

  validates :item_imgs, presence: true, length: { minimum: 1, maximum: 5 }

  validates :name,             presence: true, length: {maximum: 40}
  validates :price,            presence: true
  validates :introduction,          presence: true, length: {maximum: 1000}
  validates :postage_payer_id,         presence: true
  validates :prefecture_code,    presence: true
  validates :preparation_day_id,     presence: true
  validates :postage_type_id,  presence: true
  validates :item_condition_id,           presence: true
  validates :category_id,    presence: true

  def self.search(search)
    if search
      Item.where(['name LIKE ?', "%#{search}%"])
    else
      Item.all
    end
  end
  
end
