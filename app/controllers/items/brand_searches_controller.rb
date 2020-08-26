class Items::BrandSearchesController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json do
        if params[:parent_id] && params[:children_id] && params[:grandchildren_id]
          @brands = Brand.search_brands(
            params[:keyword], 
            [params[:parent_id], params[:children_id], params[:grandchildren_id]]
          )
        end
      end
    end
  end
end
