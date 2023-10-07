# frozen_string_literal: true

Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root to: redirect('/movies')
  get 'movies/:id/same_director', to: 'movies#show_by_director', as: :same_director
end
