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
    get "dashboard", to: "users#index"
    resources :categories do
      resources :subcategories
    end
  end
  scope module: "user" do
    get "index", to: "users#index"
    resources :budgets
    resources :expenses
    resources :wallets
    resources :reports
  end
end
