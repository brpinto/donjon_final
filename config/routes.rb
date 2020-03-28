Rails.application.routes.draw do

  root 'notes#index'

  get '/dashboard', to: 'stats#show'
  get '/dashboard-json', to: 'stats#index', as: :data

  localized do
    get '/login', to: 'sessions#new', as: 'new_session'
    post '/login', to: 'sessions#create'

    delete '/logout', to: 'sessions#destroy', as: :destroy_session

    get '/signin', to: 'users#new', as: :sign_in

    get '/lost-password', to: 'passwords#new', as: :lost_password

    get '/new-note', to: 'notes#new', as: :note_new

    get '/profil', to: 'users#edit', as: 'profil'
    patch '/profil', to: 'users#update'

    resources :notes, param: :slug
    resources :users do
      member do
        get 'confirm'
      end
    end
    resources :passwords, only: [:new, :edit, :update, :create]
  end
end
