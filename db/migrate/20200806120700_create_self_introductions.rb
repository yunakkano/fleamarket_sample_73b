class CreateSelfIntroductions < ActiveRecord::Migration[5.2]
  def change
    create_table :self_introductions do |t|
      t.text :introduction, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
