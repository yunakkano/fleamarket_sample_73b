class CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @comment = @item.comments.build(comment_params)
    @comment = Comment.new(comment_params)
    if @comment.save
      respond_to do |format|
        # format.html {redirect_to item_path(@item)}
        format.json
        # format.json {render json: @comment}
      end
    else
      flash.now[:alert] = 'コメントを入力してください。'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
