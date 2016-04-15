Rails.application.routes.draw do

  resources :wikis do
    resources :collaborators, only: [:new, :create, :destroy]
  end

  resources :charges, only: [:new, :create]

  devise_for :users
  resources :users, only: [:update, :show] do
    post 'downgrade'
  end

  get 'welcome/index'
  get 'welcome/about'
  root 'welcome#index'
end
