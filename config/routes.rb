Rails.application.routes.draw do

  get "sessions/index" 
  root "homes#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end