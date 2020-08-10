class FavoritesController < ApplicationController
  before_action :set_item 

  def create
    @favorite = current_user.favorites.new(item_id: params[:item_id])
    @favorite.save
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, item_id: params[:item_id])
    @favorite.destroy
  end

  private

  def set_item
    @item = Item.find_by(id: params[:item_id])
  end
end