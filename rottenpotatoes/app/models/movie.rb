# frozen_string_literal: true

class Movie < ActiveRecord::Base
  def others_by_same_director
    return [] if director.blank?

    Movie.where(director:).where.not(id:)
  end
end
