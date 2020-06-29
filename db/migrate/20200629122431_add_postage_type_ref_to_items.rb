class AddPostageTypeRefToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :postage_type, null: false, foreign_key: true
  end
end
