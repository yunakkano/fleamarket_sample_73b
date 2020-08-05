class Users::SendingDestinationsController < ApplicationController
    before_action :set_parents, only: [:edit, :update]
    def edit
        @address = SendingDestination.find_by(user_id: current_user.id)
    end

    def update
        @address = SendingDestination.new(address_params)

        unless @address.valid?
          flash.now[:alert] = @address.errors.full_messages
          render :edit and return
        end
    
        unless @address.save
          flash.now[:alert] = @user.errors.full_messages
          render :edit and return
        end
    end

    private
    def address_params
        params.require(:sending_destination).permit(
          :dest_first_name,       :dest_family_name,
          :dest_first_name_kana,  :dest_family_name_kana,
          :building_name,         :post_code,
          :prefecture_code,       :city,
          :street_number,         :phone_number
        )
    end

end
