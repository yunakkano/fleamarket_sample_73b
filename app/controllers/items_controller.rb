class ItemsController < ApplicationController
  before_action :set_parents, only: [:index, :new, :create, :show]
  before_action :set_item, only: [:show, :purchase, :pay, :card_show]
  before_action :set_card, only: [:purchase, :pay, :card_show]

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
    @item.trading_status = 0
    @item.seller_id = current_user.id
    if @item.save
      redirect_to root_path
    else
      @item.item_imgs.new
      render :new
    end
  end

  def search
    respond_to do |format|
      format.html
      format.json do
        if params[:parent_id]
          @childrens = Category.find(params[:parent_id]).children
        elsif params[:children_id]
          @grandChilds =Category.find(params[:children_id]).children
        end
      end
    end
  end


  def show
    @item = Item.includes(:item_imgs).find(params[:id])
    @seller = User.find(@item.seller_id)
    @seller_items = Item.includes(:item_imgs).where(seller_id: @item.seller_id).limit(6)
    @buyer = User.find(@item.buyer_id) if @item.buyer_id
    @item_condition = ItemCondition.find(@item.item_condition_id)
    @postage_type = PostageType.find(@item.postage_type_id)
    @postage_payer = PostagePayer.find(@item.postage_payer_id)
    @preparation_day = PreparationDay.find(@item.preparation_day_id)
    @prefecture = JpPrefecture::Prefecture.find(@item.prefecture_code)
    @category_grandchild = Category.find(@item.category_id)
    @category_child = @category_grandchild.parent
    @category_parent = @category_child.parent
    @category_items = Item.includes(:item_imgs).where(category_id: @item.category_id).limit(6)
  end
  
  def purchase
    # @itemid = Item.find_by(id:params[:id])
    Payjp.api_key = Rails.application.credentials[:payjp_private_key]
    if not @card.blank?
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    Payjp.api_key = Rails.application.credentials[:payjp_private_key]
    Payjp::Charge.create(
      :amount => @item.price, #支払金額を入力（itemテーブル等に紐づけても良い）
      :customer => @card.customer_id, #顧客ID
      :currency => 'jpy', #日本円
    )
    @item.trading_status = 1
    @item.buyer_id = current_user.id
    @item.save
    redirect_to action: :done
  end

  def done
  end

  # def card_show
  #   if @card.blank?
  #     redirect_to action: "new" 
  #   else
  #     Payjp.api_key = Rails.application.credentials[:payjp_private_key]
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