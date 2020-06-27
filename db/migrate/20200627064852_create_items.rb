class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.integer :item_img, null: false, foreign_key:true, type: :bigint
      t.references :category, null: false, foreign_key:true, type: :bigint
      t.references :brand, foreign_key:true, type: :bigint
      t.references :item_condition, null: false, foreign_key:true, type: :bigint
      t.references :postage_payer, null: false, foreign_key:true, type: :bigint
      t.references :preparation_day, null: false, foreign_key:true, type: :bigint
      t.references :postage_type, null: false, foreign_key:true, type: :bigint
      t.integer :prefecture_code, null: false
      t.integer :trading_status, null: false, limit: 1
      t.references :seller, null: false, foreign_key:true, type: :bigint
      t.references :buyer, foreign_key:true, type: :bigint
      t.timestamps
    end
  end
end
