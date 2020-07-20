class ItemsController < ApplicationController
  # before_action :set_item, only: [:show, :purchase, :pay]

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
    @item = Item.find(params[:id])
  end
  
  def purchase
    @item = Item.find(params[:id])
    # 登録したcardを表示させるため、cards/showを呼び出す必要がある
    # render template:'cards/show'
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = "sk_test_b846970e4339aacd4d2503c7"
    customer = Payjp::Customer.retrieve(card.customer_id)
    @default_card_information = customer.cards.retrieve(card.card_id)
  end

  def pay
    @item = Item.find(params[:id])
    Payjp.api_key = "sk_test_b846970e4339aacd4d2503c7"
    charge = Payjp::Charge.create(
    amount: @item.price,
    card: params['payjp-token'],
    currency: 'jpy'
    )
    redirect_to action: :done
  end

  def done
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
