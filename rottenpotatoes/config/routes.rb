Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  match '/director/:id', to: 'movies#director', as: 'search_directors', via: [:get]
end
