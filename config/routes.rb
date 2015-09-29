Rails.application.routes.draw do
  resources :games do
    resources :characters, :abilities
  end
  devise_for :users, controllers: {registrations: 'users/registrations'}

  authenticated :user do
    root to: "games#index", as: :authenticated_root
  end

  unauthenticated do
    as :user do
      root to: "devise/sessions#new"
    end
  end
end
