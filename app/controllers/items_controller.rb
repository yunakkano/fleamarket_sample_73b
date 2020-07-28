class ItemsController < ApplicationController
  before_action :set_parents, only: [:index, :new, :create]

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

  # 商品出品ページのカテゴリー選択における、選択した親IDに該当する子IDの検索
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

  def set_parents
    @parents = Category.where(ancestry: nil)
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