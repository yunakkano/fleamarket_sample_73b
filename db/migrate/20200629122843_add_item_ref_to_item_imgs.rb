class AddItemRefToItemImgs < ActiveRecord::Migration[5.2]
  def change
    add_reference :item_imgs, :item, null: false, foreign_key: true
  end
end
