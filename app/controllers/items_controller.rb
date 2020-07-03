class ItemsController < ApplicationController
  def index
    @items = Item.includes(:item_imgs).order("created_at DESC")
  end
end