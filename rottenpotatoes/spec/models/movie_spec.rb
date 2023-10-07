require 'rails_helper'

RSpec.describe Movie, type: :model do
  before(:all) do
    # Clear out the movies table to start fresh
    Movie.destroy_all

    @big_hero = Movie.create(title: 'Big Hero 6', director: 'Don Hall', rating: 'PG', release_date: '2014-11-07')
    @zootopia = Movie.create(title: 'Zootopia', director: 'Byron Howard', rating: 'PG', release_date: '2016-03-04')
    @moana = Movie.create(title: 'Moana', director: 'Don Hall', rating: 'PG', release_date: '2016-11-23')
  end

  describe 'others_by_same_director method' do
    it 'returns all other movies by the same director' do
      similar_movies = @big_hero.others_by_same_director
      expect(similar_movies).to include(@moana)
      expect(similar_movies).not_to include(@zootopia)
      expect(similar_movies).not_to include(@big_hero)
    end

    it 'does not return movies by other directors' do
      similar_movies = @zootopia.others_by_same_director
      expect(similar_movies).not_to include(@big_hero)
      expect(similar_movies).not_to include(@moana)
    end

    it 'returns an empty array if the director is nil or empty' do
      movie_without_director = Movie.create(title: 'Unknown', rating: 'PG', release_date: '2020-01-01')
      expect(movie_without_director.others_by_same_director).to eq([])
    end
  end
end
