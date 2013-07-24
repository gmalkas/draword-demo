DrawordDemo::Application.routes.draw do
  root 'home#index'
  resources :games
end
