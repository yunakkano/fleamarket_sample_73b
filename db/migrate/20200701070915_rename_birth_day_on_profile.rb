class RenameBirthDayOnProfile < ActiveRecord::Migration[5.2]
  def change
    rename_column :profiles, :birth_day, :birthday
  end
end
