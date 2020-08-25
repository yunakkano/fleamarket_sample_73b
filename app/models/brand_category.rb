class BrandCategory < ApplicationRecord
    belongs_to :brand
    belongs_to :category

    def brand_category_ids
        ["1", "155", "200", "345", "480", "481", "673", "731", "793", "893", "894", "978", "1198", "1199", "1205", "1233", "1271"]
    end
end
