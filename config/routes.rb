Rails.application.routes.draw do
  namespace :user do
    get "reports/index"
  end
  namespace :admin do
    get "admins/index"
  end
  get "sessions/index"
  root "homes#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
