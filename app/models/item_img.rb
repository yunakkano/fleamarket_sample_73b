class ItemImg < ApplicationRecord
  mount_uploader :url, ItemImgUploader
  belongs_to :item
end
