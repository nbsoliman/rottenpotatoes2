# frozen_string_literal: true

# MoviesHelper is dedicated to methods specifically meant for aiding the views related to movies.
# It encapsulates the logic needed for presenting movies in views.
module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ? 'odd' : 'even'
  end
end
