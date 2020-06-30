class AddPreparationDayRefToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :preparation_day, null: false, foreign_key: true
  end
end
