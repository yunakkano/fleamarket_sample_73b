class Items::SearchesController < ApplicationController
  before_action :set_parents
  def index
    @items = Item.search(params[:keyword])
  end
end
