class BrandsController < ApplicationController
    before_action :set_parents, only: [:index, :show]
    def index
        @brand_categories = Category.where(id: BrandCategory.select(:category_id).distinct)
        @ladies_hash = Brand.indexed_brands_hash(1)
        @index_list = @ladies_hash.keys
    end

    def show
        @brand = Brand.find(params[:id])
        @items = Item.where(brand_id: params[:id]).order("created_at DESC").page(params[:page]).per(30)
    end
end
