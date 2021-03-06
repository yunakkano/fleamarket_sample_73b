class Users::OnSaleItemsController < ApplicationController
  before_action :set_parents, only: [:index]

  def index
    @items = Item.includes(:item_imgs).where(seller_id: current_user.id, buyer_id: nil).order("created_at DESC").page(params[:page]).per(30)
  end

end
