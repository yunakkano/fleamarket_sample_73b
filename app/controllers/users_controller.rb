class UsersController < ApplicationController
    before_action :set_parents

    def show
        if not request.referrer
            redirect_to root_path
            return
        end
        @user = User.find(current_user.id)
        @card = Card.find_by(user_id: current_user.id)
    end

    def favorites
        Favorite.find_by(user_id: current_user.id, item_id: params[:item_id])
    end
end
