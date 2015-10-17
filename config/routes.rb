Rails.application.routes.draw do
  namespace :admin do
  get 'states/index'
  end

  namespace :admin do
  get 'states/new'
  end

  namespace :admin do
  get 'states/create'
  end

  get 'comments/create'

  namespace :admin do
    get 'permissions/index'
  end

  namespace :admin do
    root to: 'base#index'
    resources :users do
      resources :permissions

      put 'permissions', to: 'permissions#set', as: 'set_permissions'
    end

    resources :states do
      member do
        get :make_default
      end
    end
  end

  get 'sessions/new'

  get 'users/new'

  get 'users/create'

  get 'users/show'

  get 'signin', to: 'sessions#new'

  post 'signin', to: 'sessions#create'

  delete 'signout', to: 'sessions#destroy', as: 'signout'
  root 'projects#index' 

  resources :projects do
    resources :tickets
  end

  resources :tickets do
    resources :comments
  end

  resources :files

  resources :users
end
