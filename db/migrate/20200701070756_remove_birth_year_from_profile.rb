class RemoveBirthYearFromProfile < ActiveRecord::Migration[5.2]
  def change
    remove_column :profiles, :birth_year, :date
  end
end
