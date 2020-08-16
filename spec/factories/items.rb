FactoryBot.define do
  factory :category do
    id {1}
    category {"テストカテゴリー"}
    ancestry {"親カテゴリー"}
  end

  factory :item do
    name {"テスト"}
    introduction {"テスト説明"}
    price {5000}
    category_id {3}
    item_condition_id {1}
    postage_payer_id {2}
    preparation_day_id {1}
    postage_type_id {2}
    prefecture_code {2}
    trading_status {0}
    after(:build) do |item|
      item.item_imgs << build(:item_img, item: item)
    end
  end
  
  factory :item_img, class: ItemImg do     
    url         { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/test_image.jpg"), 'image/png') }
    association  :item, factory: :item   
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
end