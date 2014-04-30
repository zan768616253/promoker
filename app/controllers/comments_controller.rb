class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:event_id]
      @commentable = Event.find(params[:event_id])
      redirect_url = event_path(@commentable)
    end
    if params[:article_id]
      @commentable = Article.find(params[:article_id])
      redirect_url = article_path(@commentable)
    end
    if params[:movie_id]
      @commentable = Movie.find(params[:movie_id])
      redirect_url = movie_path(@commentable)
    end
    @comment = Comment.new(comment_params)
    @comment.commentable = @commentable
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to redirect_url }
        format.js
      else
        format.html { redirect_to redirect_url }
        format.js
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end

end