Rails.application.routes.draw do
  
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/signup' => 'users#new', as: 'signup'
  post '/signup' => 'users#create'
  
  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  # Routes for Google authentication
  get 'auth/:provider/callback', to: 'sessions#googleAuth'
  get 'auth/failure', to: redirect('/')

  # User's home
  get 'dashboard' => 'users#dashboard', as: 'dashboard'

  # Highscore for all users
  get 'highscores' => 'users#highscores', as: 'highscores'

  # Custom add quest path
  patch 'add_quest' => 'users#add_quest', as: 'addquest'

  resources :users, except: [:new] do
    resources :tasks
    resources :quests, only: [:index, :show]
    resources :skills, only: [:index, :show]
  end
  resources :tasks, only: [:index]
  resources :quests
  # resources :skills, only: [:show]
end
