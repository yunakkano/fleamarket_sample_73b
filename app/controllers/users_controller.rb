class UsersController < ApplicationController
  before_action :redirect_if_direct_access, except: [:new]
  before_action :set_parents, only: [:show, :favorites]
  before_action :search_params, only: [:new, :show, :favorites]

  def new
  end

  def show
    @target_user_id = params[:id].to_i
    if user_signed_in? && (current_user.id == @target_user_id)
      @user = User.includes(:sending_destination, :profile).find(current_user.id)
      @onsale_items = Item.includes(:item_imgs, :favorites).where(seller_id: current_user.id, buyer_id: nil).order("created_at DESC").limit(5)
      @sold_items = Item.includes(:item_imgs, :favorites).where(seller_id: current_user.id).where.not(buyer_id: nil).order("created_at DESC").limit(5)
      @purchased_items = Item.includes(:item_imgs, :favorites).where(buyer_id: current_user.id).order("created_at DESC").limit(5)
    else
      @user = User.includes(:profile, :self_introduction).find(@target_user_id)
      @items = Item.includes(:item_imgs, :favorites).where(seller_id: @user.id)
    end
  end

  def favorites
    Favorite.find_by(user_id: current_user.id, item_id: params[:item_id])
  end
end
