class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :purchase, :pay]
  before_action :set_card, only: [:purchase, :pay]

  def index
    @items = Item.includes(:item_imgs).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.item_imgs.new
    @brands = Brand.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end
  
  def purchase
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if not @card.blank?
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    Payjp::Charge.create(
      :amount => @item.price, #支払金額を入力（itemテーブル等に紐づけても良い）
      :customer => @card.customer_id, #顧客ID
      :currency => 'jpy', #日本円
    )
    redirect_to action: :done
  end

  def done
  end

  # def card_show
  #   if @card.blank?
  #     redirect_to controller: "items/cards", action: "new" 
  #   else
  #     Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  #     customer = Payjp::Customer.retrieve(@card.customer_id)
  #     @default_card_information = customer.cards.retrieve(@card.card_id)
  #   end
  # end

  def set_item
    @item = Item.find_by(id:params[:id])
  end

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

  private

  def item_params
    params.require(:item).permit(
      :name,            :introduction,              :category_id, 
      :brand_id,        :item_condition_id,         :postage_payer_id,
      :prefecture_code, :preparation_day_id,        :postage_type_id,
      :price,           item_imgs_attributes:[:url]
    )
  end
end
