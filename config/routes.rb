Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'home#index'

  #get "/articles", to: "articles#index"
  #get "/articles/:id", to: "articles#show"

  resources :articles do
    resources :comments
  end

end
