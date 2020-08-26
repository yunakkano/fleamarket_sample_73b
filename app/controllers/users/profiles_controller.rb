class Users::ProfilesController < ApplicationController
    before_action :set_parents, only: [:edit, :update]
    def edit
        @profile = Profile.find_by(user_id: current_user.id)
        @address = SendingDestination.find_by(user_id: current_user.id)
    end

    def update
        @address = SendingDestination.find_by(user_id: current_user.id)
        @address.update_attributes(address_params)
        unless @address.valid?
            flash.now[:alert] = @address.errors.full_messages
            render :index and return
        end
    end

    private
    def address_params
        params.require(:sending_destination).permit(
          :building_name,         :post_code,
          :prefecture_code,       :city,
          :street_number,         :phone_number
        )
    end
end
