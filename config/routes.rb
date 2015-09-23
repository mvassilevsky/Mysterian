Rails.application.routes.draw do
  resources :abilities
  resources :characters
  resources :games
  devise_for :users
end
