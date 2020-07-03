class CreateItemImgs < ActiveRecord::Migration[5.2]
  def change
    create_table :item_imgs do |t|
      t.string :url, null: false
      t.timestamps
    end
  end
end
