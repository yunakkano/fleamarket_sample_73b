class ChangePhoneNumberAndPostCodeToBeStringInSendingDestination < ActiveRecord::Migration[5.2]
  def change
    change_column :sending_destinations, :phone_number, :string
    change_column :sending_destinations, :post_code, :string
  end
end
