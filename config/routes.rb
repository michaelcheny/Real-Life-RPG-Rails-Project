Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root 'welcome#index'

  get '/signup' => 'users#new', as: 'signup'
  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get 'dashboard' => 'users#dashboard', as: 'dashboard'

  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
