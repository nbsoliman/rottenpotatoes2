# frozen_string_literal: true

# This is the main application controller from which other controllers inherit.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
