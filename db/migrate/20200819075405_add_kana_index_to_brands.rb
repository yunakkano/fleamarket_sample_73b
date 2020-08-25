class AddKanaIndexToBrands < ActiveRecord::Migration[5.2]
  def change
    add_column :brands, :kana_index, :string, null: false
  end
end
