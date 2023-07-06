Rails.application.routes.draw do
  root to: "homes#index"
  get "home", to: "homes#new", as: :home
  get "login", to: "sessions#new", as: :login
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout

  namespace :admin do
    get "index", to: "admins#index"
    get "users", to: "users#index"
    get "user/new", to: "users#new", as: :new_user
    post "user/create", to: "users#create", as: :create_user
    delete "user/destroy/:id", to: "users#destroy", as: :delete_user
    resources :categories
  end
  scope module: "user" do
    get "index", to: "users#index"
    resources :budgets
    resources :expenses
    resources :credits
    resources :wallets
  end
end
