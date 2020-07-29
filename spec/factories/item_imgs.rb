# FactoryBot.define do    
#   factory :item_img, class: ItemImg do     
#     url        {File.open("#{Rails.root}/spec/fixtures/test_image.jpg")}     
#     association  :item, factory: :item   
#   end
# end