module BrandHelper
    def pick_up_brands
        [
            {name:"シャネル",         path:"brand_path(#{Brand.find_by(brand:"シャネル").id})"},
            {name:"ナイキ",           path:"brand_path(#{Brand.find_by(brand:"ナイキ").id})"},
            {name:"ルイ ヴィトン",     path:"brand_path(#{Brand.find_by(brand:"ルイ ヴィトン").id})"},
            {name:"シュプリーム",      path:"brand_path(#{Brand.find_by(brand:"シュプリーム").id})"},
            {name:"アディダス",        path:"brand_path(#{Brand.find_by(brand:"アディダス").id})"},
            {name:"ユニクロ",          path:"brand_path(#{Brand.find_by(brand:"ユニクロ").id})"},
            {name:"ギャップ",          path:"brand_path(#{Brand.find_by(brand:"ギャップ").id})"},
            {name:"ザラ",             path:"brand_path(#{Brand.find_by(brand:"ザラ").id})"},
            {name:"エイチ アンド エム", path:"brand_path(#{Brand.find_by(brand:"エイチ アンド エム").id})"},
            {name:"ミュウ ミュウ",      path:"brand_path(#{Brand.find_by(brand:"ミュウ ミュウ").id})"},
            {name:"グッチ",            path:"brand_path(#{Brand.find_by(brand:"グッチ").id})"},
            {name:"カルティエ",         path:"brand_path(#{Brand.find_by(brand:"カルティエ").id})"},
            {name:"ブランド一覧",       path:"brands_path"}
        ]
    end
end