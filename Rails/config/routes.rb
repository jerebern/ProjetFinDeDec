Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root to: "angular#index"
  namespace :api, constraints: { format: 'json' }  do
    resources :todos
  end

  match '*url', to: "angular#index", via: :get # le parametre url contiendra tout ce qui suit l'étoile dans l'url
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
