class CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @comment = @item.comments.new(params[:comment])
    @comment.user_id = current_user.id
    @comment.save
    unless @item.user_id == current_user.id
      Notifier.comment_posted(@comment).deliver
    end
    redirect_to item_path(@item)
  end
  
  def destroy
    @item = Item.find(params[:item_id])
    @comment = @item.comments.find(params[:id])
    @comment.destroy
    redirect_to item_path(@item)
  end
  
  def notify_admin
    @comment = Comment.find(params[:id])
    Notifier.notify_admin(@comment).deliver
    redirect_to item_path(@comment.item), :notice => "Comment has been flagged as inapproriate."
  end
end
  