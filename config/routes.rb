Rails.application.routes.draw do

  resources :games do
    resources :characters
  end
  devise_for :users, controllers: {registrations: 'users/registrations'}

  authenticated :user do
    root to: "games#index", as: :authenticated_root
  end

  post 'abilities/add', to: "character_abilities#add_character_ability"
  delete 'abilities/:id', to: "character_abilities#delete_character_ability"

  unauthenticated do
    as :user do
      root to: "devise/sessions#new"
    end
  end
end
