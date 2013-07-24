DrawordDemo::Application.routes.draw do
  root 'home#index'
  resources :games, only: [:index, :show, :create]
end
