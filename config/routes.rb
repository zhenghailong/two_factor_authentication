Rails.application.routes.draw do
  get 'mfa/index'
  get 'mfa/new'
  get 'mfa/create'
  get 'home/index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
