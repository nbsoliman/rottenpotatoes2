# frozen_string_literal: true

# The CreateMovies migration is responsible for creating the initial movies table in the database.
# It defines the schema and structure of the movies table.
class CreateMovies < ActiveRecord::Migration[6.1]
  def up
    create_table :movies do |t|
      t.string :title
      t.string :rating
      t.text :description
      t.datetime :release_date
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :movies
  end
end
