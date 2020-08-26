class Brand < ApplicationRecord
  has_many :items
  has_many :brand_categories
  has_many :categories, through: :brand_categories
  validates :brand, presence: true, uniqueness: true
  validates :kana_index, presence: true

  def self.indexed_brands_hash(category_id)
    idices = ["ア","イ","ウ","エ","オ","カ","キ","ク","ケ","コ","サ","シ","ス","セ","ソ","タ","チ","ツ","テ","ト","ナ","ニ","ヌ","ネ","ノ","ハ","ヒ","フ","ヘ","ホ","マ","ミ","ム","メ","モ","ヤ","ユ","ヨ","ラ","リ","ル","レ","ロ","ワ","ヲ","三","1","2","3","4","5","6","7","8","9","0"]
    hash = {}
    idices.each do |idx|
      brands = Brand.joins(:categories).merge(Category.where(id: category_id.to_s)).where(kana_index: idx)
      hash[idx]=brands if brands.present?
    end
    hash
  end

  def self.search_brands(keyword, category_ids)
    return nil if keyword == "" or category_ids.length == 0
    Brand.joins(:categories).merge(
      Category.where(id: category_ids)
    ).where(['brand collate utf8_unicode_ci LIKE ?', "%#{keyword}%"])
  end
end
