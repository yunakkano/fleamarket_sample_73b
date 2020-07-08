FactoryBot.define do
    factory :profile do
        first_name        {"太郎"}
        family_name       {"山田"}
        first_name_kana   {"たろう"}
        family_name_kana  {"やまだ"}
        birthday          {Date.today-rand(10000)}
    end
  end