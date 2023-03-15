Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "recipes#public_index"
  get '/users/:user_id/foods', to: 'foods#index'
  get '/users/:user_id/foods/new', to: 'foods#new'
  post '/users/:user_id/foods/create', to: 'foods#create'
end
