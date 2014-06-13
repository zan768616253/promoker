# coding: utf-8
class MoviesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
	def index
		@locations = Tag.tags_on(:location)
		@types = Tag.tags_on(:movie_type)
    if(params[:location] || params[:type])
      @movies = Movie.tagged_with([params[:location], params[:type]]).page(params[:page])
    else
      @movies = Movie.all.page(params[:page])
    end

  end

  def show
    @movie = Movie.find(params[:id])
    @director = @movie.director
    @actors = @movie.actors
  end

  def like 
    movie = Movie.find(params[:id])
    movie.liked_by current_user
    render :text => movie.likes.size
  end
  def unlike
    movie = Movie.find(params[:id])
    movie.unliked_by current_user
    render :text => movie.likes.size
  end
end