FactoryBot.define do
  factory :item do
    id {1}
    name {"テスト"}
    introduction {"テスト説明"}
    price {5000}
    category_id {1}
    item_condition_id {1}
    postage_payer_id {2}
    preparation_day_id {1}
    postage_type_id {2}
    prefecture_code {2}
    after(:build) do |item|
      item.item_imgs<< build(:item_img, item: item)
    end
  end

  factory :item_no_picture ,class: Item do
    name              {"abe"}
    introduction                 {"あああああああああああああああ"}
    price              {1000}
    prefecture_code {2}
    postage_payer_id {1}
    postage_type_id {1}
    preparation_day_id {1}
    item_condition_id {1}
    category_id {1}
  end

  factory :item_6_picture ,class: Item do
    name              {"abe"}
    introduction                 {"あああああああああああああああ"}
    price              {1000}
    prefecture_code {2}
    postage_payer_id {1}
    postage_type_id {1}
    preparation_day_id {1}
    item_condition_id {1}
    category_id {1}
    after(:build) do |item|
      item.item_imgs<< build(:item_img, item: item)
      item.item_imgs<< build(:item_img, item: item)
      item.item_imgs<< build(:item_img, item: item)
      item.item_imgs<< build(:item_img, item: item)
      item.item_imgs<< build(:item_img, item: item)
      item.item_imgs<< build(:item_img, item: item)
    end

  end
end