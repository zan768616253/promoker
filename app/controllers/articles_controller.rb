class ArticlesController < ApplicationController
  def index
    @articles = Article.page(params[:page])
  end
  def show
    @article = Article.find(params[:id])
    @relates = Article.offset(rand(Article.count)).limit(4)
  end
end