# rubocop:disable all
# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'homes#index'
  get 'home', to: 'homes#new', as: :home
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout
  resources :notifications, only: [:index]

  namespace :admin do
    get 'index', to: 'admins#index'
    get 'users', to: 'users#index'
    get 'user/new', to: 'users#new', as: :new_user
    post 'user/create', to: 'users#create', as: :create_user
    delete 'user/destroy/:id', to: 'users#destroy', as: :delete_user
    resources :dashboards, only: [:index] do
      put :approve, on: :member
      put :reject, on: :member
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
