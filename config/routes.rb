Rails.application.routes.draw do
  root "homes#index"

  get "home", to: "homes#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  namespace :admin do
    get "index", to: "admins#index"
    get "users", to: "users#index"
    get "user/create", to: "users#new"
    post "user/create", to: "users#create"
  end
  scope module: "user" do
    get "index", to: "users#index"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
