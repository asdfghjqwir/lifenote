class PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
  if  comment.save
    flash[:notice] = "コメントが追加されました。"
  else
    flash[:alert] = "コメントの追加に失敗しました。"
  end
    redirect_to request.referer
  end

  def destroy
   comment= PostComment.find_by(id: params[:id], post_id: params[:post_id])
  if comment&.destroy
    flash[:notice] = "コメントが削除されました。"
  else
    flash[:alert] = "コメントの削除に失敗しました。"
  end
    redirect_to request.referer
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end


