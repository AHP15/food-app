Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "recipes#public_index"
  get '/users/:user_id/foods', to: 'foods#index'
  get '/users/:user_id/foods/new', to: 'foods#new'
  post '/users/:user_id/foods/create', to: 'foods#create'

  get '/users/:user_id/recipes', to: 'recipes#index', as: 'user_recipes'
  get '/users/:user_id/recipes/new', to: 'recipes#new'
  get '/users/:user_id/recipes/:id', to: 'recipes#show', as: 'user_recipe'
  post '/users/:user_id/recipes/create', to: 'recipes#create'
  put 'users/:user_id/recipes/:id/toggle', to: 'recipes#toggle', as: 'toggle_public_recipe'
  delete '/users/:user_id/recipes/:id', to: 'recipes#destroy', as: 'delete_user_recipe'

  get '/users/:user_id/recipes/:id/shopping_list', to: 'recipes#shopping'
end
