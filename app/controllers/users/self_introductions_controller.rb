class Users::SelfIntroductionsController < ApplicationController
    before_action :set_parents, only: [:new, :create, :edit, :update]
    before_action :set_user_intro, only: [:new, :create, :edit, :update]
    
    def new
        redirect_to edit_user_self_introduction_path(@user.id, @intro.id) if @intro.present?
    end

    def create
        @intro = SelfIntroduction.new(intro_params_new)
        unless @user.update_attributes(nickname_params) && @intro.save
            puts "Failed to create"
            flash.now[:alert] = @user.errors.full_messages.concat @intro.errors.full_messages
            render :new and return
        end
    end

    def edit
        redirect_to new_user_self_introduction_path(@user.id) unless @intro.present?
    end

    def update
        unless @user.update_attributes(nickname_params) && @intro.update_attributes(intro_params_edit)
            puts "Failed to update"
            flash.now[:alert] = @user.errors.full_messages.concat @intro.errors.full_messages
            render :edit and return
        end
    end

    private
    def set_user_intro
        @user = current_user
        @intro = SelfIntroduction.find_by(user_id: current_user.id)
    end

    def nickname_params
        params.require(:user).permit(:nickname)
    end

    def intro_params_new
        params.permit(:introduction, :user_id)
    end

    def intro_params_edit
        params.require(:self_introduction).permit(:introduction).merge(user_id: current_user.id)
    end
end
