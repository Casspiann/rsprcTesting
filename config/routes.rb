Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # resources :admin_users
  post 'password_reset', to: 'password_reset#create'

  resources :users
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
