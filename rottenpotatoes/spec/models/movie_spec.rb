# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  before do
    # Clear out the movies table to start fresh
    described_class.destroy_all
  end

  let!(:big_hero) do
    described_class.create(title: 'Big Hero 6', director: 'Don Hall', rating: 'PG', release_date: '2014-11-07')
  end
  let!(:zootopia) do
    described_class.create(title: 'Zootopia', director: 'Byron Howard', rating: 'PG', release_date: '2016-03-04')
  end
  let!(:moana) do
    described_class.create(title: 'Moana', director: 'Don Hall', rating: 'PG', release_date: '2016-11-23')
  end

  describe 'others_by_same_director method' do
    let(:similar_movies) { big_hero.others_by_same_director }

    it 'includes movies by the same director' do
      expect(similar_movies).to include(moana)
    end

    it 'does not include movies by a different director' do
      expect(similar_movies).not_to include(zootopia)
    end

    it 'does not include the movie itself in the results' do
      expect(similar_movies).not_to include(big_hero)
    end

    describe 'others_by_same_director method for a movie by a specific director' do
      let(:similar_movies) { zootopia.others_by_same_director }

      it 'does not include movies by different directors' do
        expect(similar_movies).not_to include(big_hero)
      end

      it 'does not include other movies by the same director' do
        expect(similar_movies).not_to include(moana)
      end
    end

    it 'returns an empty array if the director is nil or empty' do
      movie_without_director = described_class.create(title: 'Unknown', rating: 'PG', release_date: '2020-01-01')
      expect(movie_without_director.others_by_same_director).to eq([])
    end
  end
end
