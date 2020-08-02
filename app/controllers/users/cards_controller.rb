class Users::CardsController < ApplicationController
    before_action :set_parents, only: [:index, :new, :create]
    before_action :set_card, only: [:index, :new, :destroy]

    def index
        if @card.blank?
            redirect_to action: :new 
        else
            Payjp.api_key = Rails.application.credentials[:payjp_private_key]
            customer = Payjp::Customer.retrieve(@card.customer_id)
            @default_card_information = customer.cards.retrieve(@card.card_id)
        end
    end

    def new
        redirect_to action: :index if @card.present?
    end

    def create
    end

    def destroy
        if @card.present?
            Payjp.api_key = Rails.application.credentials[:payjp_private_key]
            customer = Payjp::Customer.retrieve(@card.customer_id)
            customer.delete
            @card.delete
        end
        redirect_to action: :new
    end

    private
    def set_parents
        @parents = Category.where(ancestry: nil)
    end

    def set_card
        @card = Card.find_by(user_id: current_user.id)
    end
end
