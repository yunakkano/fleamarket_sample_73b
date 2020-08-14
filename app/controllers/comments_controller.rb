class CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    comment = Comment.create(comment_params)
    if comment.save
      redirect_to item_path(@item)
    else
      puts "コメントの投稿に失敗しました"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
