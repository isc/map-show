Rails.application.routes.draw do
  resources :players
  resources :games, only: [] do
    post :answer, on: :member
  end
  get '/tv', to: 'games#tv'
  root to: 'games#index'
end
