class Movie < ActiveRecord::Base
def others_by_same_director
    return [] if self.director.blank?
    Movie.where(director: self.director).where.not(id: self.id)
  end
end
