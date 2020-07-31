class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  before_action :set_parents, only: [:index, :show]

  def show
    # @items = @category.items の記述では、@categoryが孫の場合しか商品情報を取得出来ないため、モデルメソッド set_itemsにより、カテゴリー内の適切な商品を取得する
    @items = @category.set_items
    # 未購入商品を1 ページあたり9件表示
    @items = @items.where(buyer_id: nil).order("created_at DESC").page(params[:page]).per(9)
  end

  private
  def set_category
    @category = Category.find(params[:id])

    if @category.has_children?
      @category_links = @category.children
    else
      # siblings：兄弟レコード（同じ階層のレコード）を返す
      @category_links = @category.siblings
    end
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end
end
