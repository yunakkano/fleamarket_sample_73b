FactoryBot.define do
    factory :sending_destination do
        dest_first_name        {"太郎"}
        dest_family_name       {"山田"}
        dest_first_name_kana   {"たろう"}
        dest_family_name_kana  {"やまだ"}
        city                   {"第一区"}
        building_name          {"第一ビルヂング"}
        post_code              {"1234567"}
        prefecture_code        {3}
        street_number          {"１丁目１ー１"}
        phone_number           {"12345678901"}
    end
  end