class Users::PurchasedItemsController < ApplicationController
  before_action :set_parents, only: [:index]

  def index
    @items = Item.includes(:item_imgs).where(buyer_id: current_user.id).order("created_at DESC").page(params[:page]).per(30)
  end
end
