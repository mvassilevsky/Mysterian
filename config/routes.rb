Rails.application.routes.draw do

  get 'invited_users/invite_user'

  resources :games do
    resources :characters
  end
  devise_for :users, controllers: {registrations: 'users/registrations'}

  authenticated :user do
    root to: "games#index", as: :authenticated_root
  end

  post 'abilities/add', to: "character_abilities#add_character_ability"
  delete 'abilities/:id', to: "character_abilities#delete_character_ability"

  post 'games/:id/invite_user', to: "invited_users#invite_user"
  post 'games/:game_id/characters/:character_id/invite_user', to: "invited_users#invite_user"

  unauthenticated do
    as :user do
      root to: "devise/sessions#new"
    end
  end
end
