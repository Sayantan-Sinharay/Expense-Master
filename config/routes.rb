# rubocop:disable all

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root to: 'homes#index'
  get 'home', to: 'homes#new', as: :home
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout
  get 'user_registration', to: 'users#new'
  patch 'user_registration', to: 'users#create'
  resources :notifications, only: [:index]

  namespace :admin do
    get 'index', to: 'admins#index'
    get 'users', to: 'users#index'
    get 'user/new', to: 'users#new', as: :new_user
    post 'user/create', to: 'users#create', as: :create_user
    delete 'user/destroy/:id', to: 'users#destroy', as: :delete_user
    resources :dashboards, only: [:index] do
      put :approved, on: :member
      get :reject, on: :member
      put :rejected, on: :member
    end
    resources :categories do
      resources :subcategories
    end
  end

  scope module: 'users' do
    get 'index', to: 'users#index'
    resources :budgets, only: %i[index new create]
    resources :expenses, only: %i[index new create]
    resources :wallets, only: %i[index new create]
    resources :reports, only: [:index]
  end
end
