class AddCityRenameHouseNumberInSendingDestination < ActiveRecord::Migration[5.2]
  def change
    add_column  :sending_destinations, :city, :string, null: false
    rename_column :sending_destinations, :house_number, :street_number
  end
end
