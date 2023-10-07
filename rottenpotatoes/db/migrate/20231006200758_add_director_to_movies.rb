# frozen_string_literal: true

# AddDirectorToMovies migration adds a director column to the movies table.
# This is to store the name of the director associated with each movie.
class AddDirectorToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :director, :string
  end
end
