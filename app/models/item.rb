class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :comments, dependent: :destroy
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
  validate  :is_gc_category?

  def self.search(keyword)
    if keyword
      Item.where(['name LIKE ?', "%#{keyword}%"])
    else
      Item.all
    end
  end

  def is_gc_category?
    if Category.find(category_id).has_children?
      errors.add(:category_id, "カテゴリー選択が不正です。")
    end 
  end
end
