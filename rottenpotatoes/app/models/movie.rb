# frozen_string_literal: true

# The Movie class represents a movie entity in the system.
# It encapsulates the attributes and behaviors associated with a movie.
class Movie < ActiveRecord::Base
  def others_by_same_director
    return [] if director.blank?

    Movie.where(director:).where.not(id:)
  end
end
