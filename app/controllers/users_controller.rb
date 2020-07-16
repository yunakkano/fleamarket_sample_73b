class UsersController < ApplicationController
    def show
        if not request.referrer
            redirect_to root_path
            return
        end
        @user = User.find(current_user.id)
    end
end
