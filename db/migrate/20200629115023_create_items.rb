class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      # t.integer :item_img, null: false, foreign_key:true
      t.references :category, null: false, foreign_key:true
      # t.references :brand, foreign_key:true
      t.integer :item_condition_id, null: false, foreign_key:true
      t.integer :postage_payer_id, null: false, foreign_key:true
      t.integer :preparation_day_id, null: false, foreign_key:true
      t.integer :postage_type_id, null: false, foreign_key:true
      
      t.integer :prefecture_code, null: false
      t.integer :trading_status, null: false, limit: 1
      t.references :buyer, foreign_key: { to_table: :users }
      t.references :seller, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
