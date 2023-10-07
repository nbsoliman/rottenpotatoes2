# frozen_string_literal: true

class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    #   flash[:alert] = "Movie not found."
    redirect_to movies_path
  end

  def index
    @movies = Movie.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def show_by_director
    movie = Movie.find(params[:id])
    if movie.director.blank?
      flash[:warning] = "'#{movie.title}' has no director info"
      redirect_to root_path
    else
      @movies = Movie.where(director: movie.director).where.not(id: movie.id)
      flash[:warning] = 'No other movies by this director.' if @movies.empty?
    end
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id]).destroy
    # @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private

  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :release_date, :director)
  end
end
