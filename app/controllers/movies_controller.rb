class MoviesController < ApplicationController
	def index
		@locations = Movie.tag_counts_on(:locations)
		@types = Movie.tag_counts_on(:types)
		
		@movies = Movie.recent.page(params[:page])
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

end