# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  before(:all) do
    Movie.destroy_all

    @movie_with_director = Movie.create(title: 'Big Hero 6',
                                        rating: 'PG',
                                        release_date: '2014-11-07',
                                        director: 'Don Hall, Chris Williams')

    @movie_with_director2 = Movie.create(title: 'Big Hero 7',
                                         rating: 'PG',
                                         release_date: '2014-11-07',
                                         director: 'Don Hall, Chris Williams')

    @movie_without_director = Movie.create(title: 'Unknown Movie',
                                           rating: 'PG',
                                           release_date: '2015-05-05')
  end

  describe 'when trying to find movies by the same director' do
    it 'returns a valid collection when a valid director is present' do
      get :show_by_director, params: { id: @movie_with_director.id }
      expect(assigns(:movies)).not_to be_empty
    end

    it 'redirects to index with a warning when no director is present' do
      get :show_by_director, params: { id: @movie_without_director.id }

      expect(response).to redirect_to root_path
      expect(flash[:warning]).to match(/'Unknown Movie' has no director info/)
    end
  end

  describe 'creates' do
    it 'movies with valid parameters' do
      get :create, params: { movie: { title: 'Toucan Play This Game', director: 'Armando Fox',
                                      rating: 'G', release_date: '2017-07-20' } }
      expect(response).to redirect_to movies_path
      expect(flash[:notice]).to match(/Toucan Play This Game was successfully created./)
      Movie.find_by(title: 'Toucan Play This Game').destroy
    end
  end

  describe 'updates' do
    it 'redirects to the movie details page and flashes a notice' do
      movie = Movie.create(title: 'Outfoxed!', director: 'Nick Mecklenburg',
                           rating: 'PG-13', release_date: '2023-12-17')
      get :update,
          params: { id: movie.id,
                    movie: { description: 'Critics rave about this epic new thriller. Watch as main characters Armando Fox and Michael Ball, alongside their team of TAs, battle against the challenges of a COVID-19-induced virtual semester, a labyrinthian and disconnected assignment stack, and the ultimate betrayal from their once-trusted ally: Codio exams.' } }

      expect(response).to redirect_to movie_path(movie)
      expect(flash[:notice]).to match(/Outfoxed! was successfully updated./)
      movie.destroy
    end

    it 'actually does the update' do
      movie = Movie.create(title: 'Outfoxed!', director: 'Nick Mecklenburg',
                           rating: 'PG-13', release_date: '2023-12-17')
      get :update, params: { id: movie.id, movie: { director: 'Not Nick!' } }

      expect(assigns(:movie).director).to eq('Not Nick!')
      movie.destroy
    end
  end

  describe 'GET new' do
    it 'renders the new movie template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET show' do
    it 'redirects to the movies index with an alert for an invalid movie ID' do
      get :show, params: { id: 99_999 } # An ID that shouldn't exist
      expect(response).to redirect_to movies_path
      # expect(flash[:alert]).to eq("Movie not found.")
    end
  end
end
