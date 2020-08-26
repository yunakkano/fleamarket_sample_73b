class Categories::BrandsController < ApplicationController
    before_action :set_parents, only: [:index]
    def index
        @brand_categories = Category.where(id: BrandCategory.select(:category_id).distinct)
        @selected_category = Category.find(params[:category_id])
        @brands_hash = Brand.indexed_brands_hash(params[:category_id])
        @index_list = @brands_hash.keys
    end
end
