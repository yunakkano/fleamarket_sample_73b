module UserHelper
    def months_collection
      ["01","02","03","04","05","06","07","08","09","10","11","12"]
    end

    def years_collection
      current_year = Date.today.year
      years_collection_list = []
      for y in 0..10 do
          years_collection_list << {yy: (current_year + y - 2000).to_s, yyyy: (current_year + y).to_s}
      end
      years_collection_list
    end

    def card_brands
      { "logo/visa.svg":            {"height": "20", "width": "49"},
        "logo/master-card.svg":     {"height": "20", "width": "34"},
        "logo/saison-card.svg":     {"height": "20", "width": "30"},
        "logo/jcb.svg":             {"height": "20", "width": "32"}, 
        "logo/american_express.svg":{"height": "20", "width": "21"},
        "logo/dinersclub.svg":      {"height": "20", "width": "32"},
        "logo/discover.svg":        {"height": "20", "width": "32"},
      }
    end

    def sidemenu
      {
        "メニュー": [
          {title:"マイページ", path: "user_path(current_user.id)", value: "99+"},
          {title:"お知らせ", path: "user_path(current_user.id)", value: "1"},
          {title:"いいね！一覧", path: "user_path(current_user.id)", value: ""},
          {title:"出品する", path: "user_path(current_user.id)", value: ""},
          {title:"下書き一覧", path: "user_path(current_user.id)", value: ""},
          {title:"出品した商品 - 出品中", path: "user_path(current_user.id)", value: ""},
          {title:"出品した商品 - 取引中", path: "user_path(current_user.id)", value: ""},
          {title:"出品した商品 - 売却済み", path: "user_path(current_user.id)", value: ""},
          {title:"購入した商品 - 取引中", path: "user_path(current_user.id)", value: ""},
          {title:"購入した商品 - 過去の取引", path: "user_path(current_user.id)", value: ""},
          {title:"ニュース一覧", path: "user_path(current_user.id)", value: ""},
          {title:"評価一覧", path: "user_path(current_user.id)", value: ""},
          {title:"ガイド", path: "user_path(current_user.id)", value: ""},
          {title:"お問い合わせ", path: "user_path(current_user.id)", value: ""},
        ],
        "設定": [
          {title:"プロフィール", path: "user_path(current_user.id)", value: ""},
          {title:"発送元・お届け先住所変更", path: "user_path(current_user.id)", value: ""},
          {title:"支払い方法", path: "user_cards_path(current_user)", value: ""},
          {title:"メール/パスワード", path: "user_path(current_user.id)", value: ""},
          {title:"本人情報", path: "user_path(current_user.id)", value: ""},
          {title:"電話番号の確認", path: "user_path(current_user.id)", value: ""},
        ] 
      }
    end
end  