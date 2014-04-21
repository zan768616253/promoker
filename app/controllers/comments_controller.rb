class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    @comment = Comment.new(comment_params)
    @comment.commentable = @article
    @comment.user = current_user
    @comment.save!
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end

end