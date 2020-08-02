class Users::CardsController < ApplicationController
    before_action :set_parents, only: [:index, :new, :create]
    def index
    end

    def new
    end

    def create
    end

    private
    def set_parents
        @parents = Category.where(ancestry: nil)
    end
end
