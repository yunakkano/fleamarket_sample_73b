class CreatePostageTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :postage_types do |t|
      t.string :postage_type, null: false
      t.timestamps
    end
  end
end
