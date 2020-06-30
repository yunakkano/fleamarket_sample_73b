class AddPostagePayerRefToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :postage_payer, null: false, foreign_key: true
  end
end
