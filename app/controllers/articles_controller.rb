class ArticlesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  def index
    @articles = Article.recent.page(params[:page])
  end
  def show
    @article = Article.find(params[:id])
    @relates = Article.offset(rand(Article.count)).limit(4)
  end

  def like 
    article = Article.find(params[:id])
    article.liked_by current_user
    render :text => article.likes.size
  end
  def unlike
    article = Article.find(params[:id])
    article.unliked_by current_user
    render :text => article.likes.size
  end
end