class UsersController < ApplicationController
    before_action :set_parents, only: [:show]
    def show
        if not request.referrer
            redirect_to root_path
            return
        end
        @user = User.find(current_user.id)
        @card = Card.find_by(user_id: current_user.id)
    end

    private
    def set_parents
        @parents = Category.where(ancestry: nil)
    end
end
