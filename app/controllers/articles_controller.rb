class ArticlesController < ApplicationController
  def index
    @articles = Article.recent.page(params[:page])
  end
  def show
    @article = Article.find(params[:id])
    @relates = Article.offset(rand(Article.count)).limit(4)
  end

  def like 
    a = Article.find(params['article_id'])
    a.liked_by current_user
    render :text => m.likes.size
  end
  def unlike
    a = Article.find(params['article_id'])
    a.unliked_by current_user
    render :text => m.likes.size
  end
end