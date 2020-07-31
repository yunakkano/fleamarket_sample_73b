class CardsController < ApplicationController
  before_action :set_item, only: [:show, :pay, :new]
  before_action :set_card, only: [:show, :delete, :new]

  require "payjp"

  def new
    redirect_to action: "show" if @card.present?
  end

  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token']
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        # redirect_to controller: :items, action: :card_show,id:@item.id
        redirect_to card_show_item_path(@item.id)
        flash[:notice] = 'クレジットカードの登録ができました'
      else
        redirect_to action: "pay"
        flash[:notice] = 'クレジットカードの登録に失敗しました'
      end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    if @card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    end
      redirect_to action: "new"
  end

  def set_item
    @item = Item.find_by(params[:id])
  end

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end
end