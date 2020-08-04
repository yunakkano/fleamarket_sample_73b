class Users::CardsController < ApplicationController
    before_action :set_parents, only: [:index, :new, :create]
    before_action :set_card, only: [:index, :destroy]

    require "payjp"

    def index
        if @card.present?
            Payjp.api_key = Rails.application.credentials[:payjp_private_key]
            customer = Payjp::Customer.retrieve(@card.customer_id)
            @default_card_information = customer.cards.retrieve(@card.card_id)
        end
    end

    def new
        @card = Card.new
    end

    def create
        Payjp.api_key = Rails.application.credentials[:payjp_private_key]
        if params[:card_token].blank?
            redirect_to action: :new
        else
            customer = Payjp::Customer.create(
                card: params[:card_token]
                )
            @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
            if @card.save
                redirect_to action: :index
                flash[:notice] = 'クレジットカードの登録ができました'
            else
                redirect_to action: :new
                flash[:notice] = 'クレジットカードの登録に失敗しました'
            end
        end
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
