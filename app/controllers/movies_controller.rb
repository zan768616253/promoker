class MoviesController < ApplicationController
	def index
    p params
		@locations = Movie.tag_counts_on(:locations)
		@types = Movie.tag_counts_on(:types)
    if(params[:location] || params[:type])
      @movies = Movie.tagged_with([params[:location], params[:type]]).page(params[:page])
    else
      @movies = Movie.all.page(params[:page])
    end

  end

  def show
    @movie = Movie.find(params[:id])
    @director = @movie.directors.first
    @actors = @movie.actors
  end
  def top
    @movies = Movie.top.page(params[:page])
    render 'movies/index'
  end

  def hot

  end

  def like 
    m = Movie.find(params['movie_id'])
    m.liked_by current_user
    render :text => m.likes.size
  end
  def unlike
    m = Movie.find(params['movie_id'])
    m.unliked_by current_user
    render :text => m.likes.size
  end
end