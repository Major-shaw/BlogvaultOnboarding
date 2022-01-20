Rails.application.routes.draw do
  root to: 'home#index'
  resources :articles do
    resources :comments
  end

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config



  #get "/articles", to: "articles#index"
  #get "/articles/:id", to: "articles#show"


end
