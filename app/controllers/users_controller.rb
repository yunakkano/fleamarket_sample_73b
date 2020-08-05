class UsersController < ApplicationController
    before_action :set_parents, only: [:show]
    def show
        if not request.referrer
            redirect_to root_path
            return
        end
        @user = User.includes(:sending_destination).find(current_user.id)
        puts @user.sending_destination.dest_family_name
    end

end
