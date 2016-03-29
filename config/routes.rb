Rails.application.routes.draw do

  get 'charges/create'

  resources :wikis
  resources :charges, only: [:new, :create]

  devise_for :users

  get 'welcome/index'
  get 'welcome/about'
  root 'welcome#index'
end
