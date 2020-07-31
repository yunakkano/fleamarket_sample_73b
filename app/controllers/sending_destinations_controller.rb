class SendingDestinationsController < ApplicationController
  def new
    sending_destination = Sending_destination.where(user_id: current_user.id)
    redirect_to action: "show" if  sending_destination.exist?
  end

  def show
    # @sending_destination = Sending_destination.new
    if sending_destination.blank?
      redirect_to action: "new" 
    else
      render template: "users/address"
    end
  end
end
