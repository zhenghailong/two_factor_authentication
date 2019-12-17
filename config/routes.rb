Rails.application.routes.draw do
  root 'home#index'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  get 'device_setting' => 'mfa#index'
  get 'mfa_auth' => 'mfa#new'
  post 'mfa_auth' => 'mfa#create'

  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
